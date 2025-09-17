## コンポーネント図
```mermaid
flowchart TD
  subgraph UI
    M[WeatherScreen]
  end

  subgraph State Management
    S[weatherStateNotifierProvider]
    WN[WeatherStateNotifier]
    ST[WeatherState]
  end

  subgraph External
    YP[yumemiWeatherClientProvider]
    YW[YumemiWeather]
  end

  M -.->|watch/replaceable| S
  S -->|provides| ST
  S -->|creates| WN
  WN -.->|read/replaceable| YP
  YP -->|provides| YW
  WN -->|update| ST

```

## シーケンス図

### 天気情報更新フロー
```mermaid
sequenceDiagram
    participant U as User
    participant WS as WeatherScreen
    participant WN as WeatherStateNotifier
    participant API as YumemiWeather
    participant State as WeatherState

    U->>WS: Reloadボタン押下
    WS->>WN: updateWeather(area, date)
    
    WN->>WN: _fetchWeather()
    WN->>API: fetchWeather(jsonString)
    
    alt 成功時
        rect rgb(230, 255, 230)
            API-->>WN: JSON Response
            WN->>WN: JSON → Weather変換
            WN->>State: weather更新
            State-->>WS: 天気状態更新通知
            WS-->>U: UI更新（天気表示）
        end
    else エラー時
        rect rgb(255, 230, 230)
            alt APIエラー
                API-->>WN: YumemiWeatherError
            else マッピングエラー
                API-->>WN: JSON Response
                WN->>WN: JSON → Weather変換失敗
            end
            WN->>State: error更新
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
| **UI/Providers** |
| `weatherStateNotifierProvider` | `WeatherStateNotifier`と`WeatherState`の提供 |
| `yumemiWeatherClientProvider` | `YumemiWeather`のDI提供 |
| **UI/Notifiers** |
| `WeatherStateNotifier` | 天気情報の取得・状態更新・エラーハンドリング |
| `WeatherState` | 天気情報とエラー状態を保持する不変データクラス |
| **Core/Entity** |
| `Weather` | アプリ内部の天気データ |
| `WeatherCondition` | 天気状態の列挙型 |
| **Core/Request** |
| `WeatherGetRequest` | APIリクエストデータの構造化 |
| **Core/Response** |
| `WeatherGetResponse` | APIレスポンスデータの構造化 |
| **Core/Bootstrap** |
| `install_error_listener.dart` | グローバルエラーリスナーの設定 |
