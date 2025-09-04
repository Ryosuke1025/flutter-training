## コンポーネント図
```mermaid
flowchart TD
  subgraph UI
    M[MainApp/Screen]
  end

  subgraph State
    S[weatherStateProvider]
    WS[WeatherStore]
    ST[WeatherState]
  end

  subgraph Service
    P[weatherServiceProvider]
    W[WeatherService]
  end

  subgraph Actions
    AP[weatherActionsProvider]
    A[WeatherActions]
  end

  subgraph API
    YW[YumemiWeather]
  end

  M -->|read| AP
  AP --> A
  A -.->|via DI/Closure| P
  P --> W
  W -.->|via DI/Closure| WS
  W -->|fetch| YW
  WS -->|set| ST
  S -->|provides| ST
  M -->|watch| S

```

## シーケンス図

### 天気情報更新フロー
```mermaid
sequenceDiagram
    participant U as User
    participant WS as WeatherScreen
    participant WA as WeatherActions
    participant WSv as WeatherService
    participant API as YumemiWeather
    participant Store as WeatherStore
    participant State as WeatherState

    U->>WS: Reloadボタン押下
    WS->>WA: updateWeather(area, date)
    WA->>WSv: updateWeather(area, date)
    
    WSv->>WSv: _fetchWeather()
    WSv->>API: fetchWeather(jsonString)
    
    alt 成功時
        rect rgb(230, 255, 230)
            API-->>WSv: JSON Response
            WSv->>WSv: JSON → Weather変換
            WSv->>Store: setWeather(weather)
            Store->>State: weather更新
            State-->>WS: 天気状態更新通知
            WS-->>U: UI更新（天気表示）
        end
    else エラー時
        rect rgb(255, 230, 230)
            alt APIエラー
                API-->>WSv: YumemiWeatherError
            else マッピングエラー
                API-->>WSv: JSON Response
                WSv->>WSv: JSON → Weather変換失敗
            end
            WSv->>Store: setError(error)
            Store->>State: error更新
            State-->>WS: エラー状態更新通知
            Note over WS: グローバルエラーリスナーが<br/>ダイアログ表示
            WS-->>U: エラーダイアログ表示
        end
    end
```

## 各モジュールの機能

| モジュール | 責務 |
|---|---|
| **UI/Screen** |
| `WeatherScreen` | 天気情報の表示とユーザー操作の受付 |
| **UI/Widget** |
| `WeatherConditionWidget` | 天気状態のアイコン表示 |
| `WeatherTemperatureWidget` | 最高・最低気温の表示 |
| `GreenWidget` | 初期(緑)画面を表示し、遅延後に`WeatherScreen`に遷移|
| **UI/State** |
| `weatherStateProvider` | `WeatherState`の提供 |
| `WeatherStore` | `WeatherState`の変更操作 |
| `WeatherState` | 天気情報とエラー状態を保持 |
| **UI/Actions** |
| `weatherActionsProvider` | `WeatherActions`の提供 |
| `WeatherActions` | UI操作の抽象化を保持 |
| **Services/Service** |
| `weatherServiceProvider` | `WeatherStore`のメソッドをDIした`WeatherService`を提供 |
| `WeatherService` | API呼び出しとエラーハンドリングを行い、その結果に応じてクロージャを実行する |
| **Services/Request** |
| `WeatherGetRequest` | APIリクエストデータの構造化 |
| **Services/Response** |
| `WeatherGetResponse` | APIレスポンスデータの構造化 |
| **Services/Entity** |
| `Weather` | アプリ内部の天気データ |
| `WeatherCondition` | 天気状態の列挙型 |
| **Core/Bootstrap** |
| `install_error_listener.dart` | グローバルエラーリスナーの設定 |
| **Core/DI** |
| `overrides.dart` | `WeatherActions`に`WeatherService`のメソッドをDI |
