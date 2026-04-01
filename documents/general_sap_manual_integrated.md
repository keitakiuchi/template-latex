# General Statistical Analysis Plan Manual

## 研究デザイン横断で使える汎用SAP作成マニュアル

作成日: 2026-04-01  
対象: RCT、非ランダム化比較、不等価統制群、因果推論、観察研究、縦断・コホート調査、routine data を用いる研究、シミュレーション研究、系統的レビュー / メタアナリシス、機械学習予測モデル研究、必要に応じて質的研究・混合研究法の analysis protocol  
統合元: `general_statistical_analysis_plan_guide.md`、`manuscript_and_sap_guidance.md` のうち、analysis plan / SAP に関わる内容を中心に再構成

---

## 0. まず結論

Statistical Analysis Plan（SAP）は、**どのデータを、どのルールで、どの目的で、どう分析するかを、結果を見る前にできるだけ具体的に固定する文書**です。

目的は主に次の4つです。

1. **恣意性を減らすこと**
2. **再現性を高めること**
3. **研究目的と解析の整合を保つこと**
4. **査読・共同研究・将来の自分への説明責任を果たすこと**

大事な点は、臨床試験では SAP の正式ガイドラインが比較的整っていますが、研究デザイン全体を貫く単一の万能 SAP ガイドラインはまだ存在しない、ということです。

したがって実務上は、次の考え方が最も使いやすいです。

- **共通コア**
  - どの研究にも必要な SAP の骨格を作る
- **デザイン別モジュール**
  - RCT、因果推論、縦断、simulation、meta-analysis、prediction など固有論点を足す
- **報告ガイドラインやバイアス評価ツールの逆算利用**
  - 何が後で問題になるかを SAP 段階で先回りして書く

本マニュアルは、そのための汎用 SAP の考え方、推奨構成、デザイン別の読み替え、実務テンプレート、査読対応に備えるためのポイントを一つにまとめたものです。

---

## 1. SAP とは何か

### 1.1 定義

ICH E9 では、SAP は**プロトコルに書かれた解析の主要事項を、より技術的かつ詳細に具体化した文書**として位置づけられています。プロトコルが「何を検証するか」の全体設計を示すのに対し、SAP は「それを統計的にどう実行するか」の実施仕様書に近い文書です。

### 1.2 プロトコル、SAP、事前登録の違い

- **プロトコル**
  - 研究背景、目的、デザイン、対象者、測定、倫理、運営などを含む全体計画書
- **SAP / analysis plan**
  - 主に統計解析の事前計画を詳しく書く文書
  - 解析対象集団、変数定義、主解析、副次解析、欠測処理、感度分析などを詳しく書く
- **事前登録（preregistration）**
  - 研究計画や解析計画を、タイムスタンプ付きで登録する実践
  - SAP そのものを登録してもよいし、SAP を要約した登録でもよい

### 1.3 SAP は独立文書でなければならないか

必ずしもそうではありません。臨床試験では独立文書として作成されることが多いですが、研究の規模や分野によっては、プロトコル付録、登録文書、解析計画書として統合されていても構いません。

重要なのは形式ではなく、次の3点です。

- 結果を見る前にできるだけ固定されていること
- 版管理がされていること
- 変更理由が追跡できること

### 1.4 名称より役割を揃える

臨床試験では「SAP」という名前が一般的ですが、観察研究、二次データ解析、シミュレーション研究、メタアナリシス、質的研究では、次のような別名を取ることがあります。

- Statistical Analysis Plan
- Analysis Plan
- Quantitative Analysis Protocol
- Simulation Protocol
- Evidence Synthesis Protocol
- Analysis Protocol

名前が違っても、役割はほぼ同じです。

- 主解析を先に固定する
- 重要な分岐条件を先に決める
- 探索的追加分析を後から識別できるようにする

---

## 2. 最初に固定すべきこと

### 2.1 研究の問いの型

analysis plan を書き始める前に、何を答えたい研究かを固定します。最低限、次のどれが主かを明示します。

- 記述
- 関連・説明
- 因果効果推定
- 予測・分類
- 方法論・シミュレーション
- エビデンス統合

同じデータを使っていても、問いの型が違えば、必要な計画も違います。観察研究でも、「関連を述べる研究」と「因果効果を推定する研究」では、共変量調整の考え方も、感度分析の要件も違います。

### 2.2 推定対象を言葉にする

近年とても重要なのが、**結局、何を推定したいのか**を事前に言語化することです。ICH E9(R1) の estimand の考え方は、臨床試験以外にも非常に有用です。

少なくとも次を言葉にします。

- 誰について
- 何と何を比べて
- どのアウトカムについて
- いつ時点で
- どの尺度で

例:

> 40〜74歳の対象者において、ベースライン時の高曝露群と低曝露群を比較した 3 年後抑うつ症状スコアの平均差

予測研究なら prediction target、メタアナリシスなら review question と synthesis question、シミュレーション研究なら estimand と performance measure を明示します。

### 2.3 確証的解析と探索的解析を分ける

- **確証的解析**
  - 事前に主要な問い・主要解析として固定する解析
- **探索的解析**
  - 結果を見てから発見的に行う解析、追加仮説生成のための解析

両者を混ぜると、読者も査読者も解釈に困ります。SAP では、どこまでが事前規定で、どこからが探索かをはっきり書きます。

---

## 3. ガイドラインの地図

### 3.1 最も明確な SAP 内容ガイドラインは臨床試験領域にある

臨床試験では、Gamble ら（JAMA, 2017）が 55 項目からなる SAP 内容ガイドラインを提示しました。現在でも、SAP の骨格を考えるうえで最も実務的な出発点の一つです。

その大枠:

- Administrative information
- Introduction
- Study methods
- Statistical principles
- Study population / trial population
- Analysis

この構造は、臨床試験以外にもかなり流用できます。

### 3.2 非臨床試験では SAP 専用の統一ガイドラインは少ない

観察研究、調査研究、因果推論、予測モデル研究では、論文報告ガイドラインやバイアス評価ツールは豊富ですが、SAP 専用の統一ガイドラインは少ないです。

実務上は次のように考えると整理しやすいです。

- SAP の骨格は JAMA 2017 / ICH E9 の発想を借りる
- デザイン固有の要求事項は STROBE / RECORD / TREND / TARGET / TRIPOD+AI / PRISMA などから足す
- 後で問題になるバイアスは ROBINS-I / PROBAST / PROBAST+AI などから逆算して、SAP 段階で先回りして書く

### 3.3 デザインごとの主な参照先

#### RCT や比較試験

- JAMA SAP guideline
- ICH E9 / E9(R1)
- SPIRIT / CONSORT とその拡張

#### 非ランダム化比較、不等価統制群、準実験

- TREND
- ROBINS-I
- TARGET

#### 観察研究、縦断研究、コホート研究

- STROBE
- RECORD
- AAPOR disclosure standards

#### 因果推論

- ICH E9(R1) の estimand の考え方
- target trial framework
- TARGET

#### 機械学習の予測モデル研究

- TRIPOD+AI
- PROBAST / PROBAST+AI
- SAMPL

#### 系統的レビュー / メタアナリシス

- PRISMA 2020
- PRISMA-P
- Cochrane Handbook
- MOOSE

#### 質的研究・混合研究法

- APA JARS
- SRQR / COREQ

---

## 4. 汎用 SAP の基本原則

### 4.1 研究の問いを統計量に落とす

問いが曖昧だと、解析も曖昧になります。少なくとも次のいずれかに落とし込みます。

- 因果効果
- 記述量
- 関連の強さ
- 予測性能
- 方法性能
- 統合効果量

### 4.2 解析対象集団・除外ルールを結果の前に固定する

最低限、次を事前に定義します。

- 対象者選定基準
- 除外基準
- 欠測や脱落があったときの扱い
- 外れ値の扱い
- データクリーニング後にどのデータセットを本解析に使うか

### 4.3 変数定義を曖昧にしない

最低限、次を具体化します。

- 主要アウトカム
- 副次アウトカム
- 暴露・介入・比較群
- 共変量
- 層別変数
- サブグループ変数
- 派生変数
- 測定時点
- 単位、尺度、変換ルール

### 4.4 主解析モデルを一意に近づける

「適切な回帰分析を行う」では不十分です。できるだけ次を具体的に書きます。

- どのモデルを使うか
- 従属変数は何か
- 主要独立変数は何か
- どの共変量を強制投入するか
- 交互作用を見るか
- クラスタリングや反復測定をどう扱うか
- どの推定量を報告するか

### 4.5 欠測、外れ値、前提逸脱への対応を先に決める

弱い計画書は、重要な判断を後で変えられるままにしています。次のような書き方は弱いです。

- 必要に応じて共変量調整を行う
- 分布に応じて適切な方法を用いる
- 欠測が多い場合には補完を検討する
- 外れ値は適宜処理する

より強い書き方は、次のように**コードに落とせる粒度**で書くことです。

- 年齢、性別、施設、ベースライン重症度を主解析で必ず調整する
- 残差診断で前提が崩れた場合は、対数変換またはロバスト推定に切り替える
- 欠測が 5% 未満でも欠測パターンを記述し、主解析は多重代入、完全ケース解析を感度分析とする
- 外れ値は削除せず、定義済みルールに従って winsorize するかロバスト法で扱う

### 4.6 感度分析を最初から組み込む

感度分析とは、前提や分析選択が変わったときに、結論がどれくらい変わるかを確認する解析です。よい SAP は主解析だけで終わりません。

### 4.7 変更履歴を残す

SAP は一度も変更してはいけない文書ではありません。ただし変更するなら、

- いつ
- 誰が
- なぜ
- データをどの程度見た後か
- 主解析に影響するか

を記録する必要があります。

### 4.8 原稿と補足資料まで見越して書く

良い SAP は、最終論文の Methods の下書きであるだけでなく、結果表・補足資料・査読対応の材料にもなります。したがって、

- 主要図表の見出し
- データ辞書
- 補足資料で開示すべきコードリストやアルゴリズム
- 解析の分岐とその理由

まで意識しておくと、後で強いです。

---

## 5. 汎用 SAP の推奨構成

以下は、臨床試験 SAP の骨格をベースに、非臨床試験にも流用できるよう一般化した構成です。使わない項目は消すより、`N/A` と理由を書く方が透明性が高まります。

### 5.1 管理情報

含める内容:

- 文書タイトル
- SAP version と日付
- 関連するプロトコルや登録番号
- 作成者、解析責任者、承認者
- 改訂履歴
- 改訂理由
- データ固定前か後か
- 主要結果を見た後の変更か否か

### 5.2 背景と研究目的

含める内容:

- 研究の背景
- 実務、理論、政策上の意義
- 研究目的
- 主要仮説
- 副次仮説
- 探索的問い

### 5.3 研究の問い / estimand / prediction target / synthesis question

含める内容:

- 主要ターゲット
- 対象集団
- 曝露 / 介入 / 比較
- アウトカム
- time horizon
- 要約量
- 解釈
- 確証的解析と探索的解析の区別

### 5.4 研究デザインとデータソース

含める内容:

- 研究デザイン
- データソース
- データ収集時期
- 分析単位
- 追跡期間
- 介入や曝露の定義

### 5.5 研究対象と解析対象

含める内容:

- 適格基準
- 除外基準
- 登録、参加、選定フロー
- 解析対象集団の定義
- 主解析集団
- 完全ケース解析集団
- 感度分析用集団
- 予測研究なら開発用、検証用、外的検証用データセットの定義

### 5.6 主要変数の定義

含める内容:

- 主要アウトカム
- 副次アウトカム
- 暴露、介入、比較群
- 共変量
- 層別変数
- サブグループ変数
- 派生変数の作成ルール
- 測定尺度
- 単位
- 収集時点
- データ辞書への参照

### 5.7 解析タイミングと time zero

特に因果推論、縦断研究、比較研究で重要です。

含める内容:

- ベースラインの定義
- 追跡開始時点
- 追跡終了条件
- 解析時点
- 解析ウィンドウ
- 反復測定の扱い
- 打ち切りのルール

### 5.8 データ前処理・品質管理

含める内容:

- データチェックの範囲
- 論理矛盾の扱い
- 外れ値の検出ルール
- 値域外データの処理
- 日付不整合の処理
- 重複レコードの処理
- 派生変数作成の順序
- 予測研究なら leakage 防止策

### 5.9 記述統計

含める内容:

- どの変数を記述するか
- 連続変数の要約方法
- カテゴリ変数の要約方法
- 群別に出すか
- 縦断データなら時点別に出すか
- サンプルサイズの示し方
- 調査研究なら重み付き推定を使うか

### 5.10 統計原則

含める内容:

- 有意水準
- 信頼区間
- 多重性の扱い
- 片側 / 両側検定
- 効果量の優先
- 推定量中心で報告するか
- モデル仮定の確認方法
- 必要ならベイズ解析の事前分布

### 5.11 主解析

少なくとも、主解析ごとに以下を固定します。

- 解析目的
- 対象集団
- 使用データセット
- 従属変数
- 主説明変数
- 調整共変量
- 統計モデル
- 推定量
- 標準誤差やクラスタ補正の方法
- 反復測定や施設内相関の扱い
- 結果の提示形式

### 5.12 副次解析・追加解析

含める内容:

- 副次アウトカム解析
- サブグループ解析
- 交互作用解析
- メディエーション解析
- モデレーション解析
- 補足解析
- exploratory analysis として扱う解析

### 5.13 欠測データの扱い

最低限必要な点:

- 欠測の種類
- 欠測の量をどう報告するか
- 主解析での扱い
- 多重代入を使うか
- 代入モデルに入れる変数
- complete case を使うなら、その理由
- 追跡脱落や検査未実施をどう扱うか
- 予測研究での欠測処理

### 5.14 感度分析・ロバストネス分析

候補:

- 欠測処理の別法
- 共変量セットの変更
- time zero の変更
- 外れ値処理の変更
- 解析対象集団の変更
- 傾向スコア法の別仕様
- 未測定交絡への感度分析
- シミュレーション条件の変更
- メタアナリシスなら効果量選択、統合モデル、研究除外規則の別仕様
- 予測研究なら閾値、キャリブレーション、別データ分割、別乱数シード

### 5.15 仮定の確認と診断

含める内容:

- 線形性
- 正規性
- 比例ハザード性
- 多重共線性
- 残差診断
- overlap / positivity の確認
- 共変量バランス
- メタアナリシスなら異質性や影響分析
- 予測研究なら calibration / discrimination / overfitting / fairness の診断

### 5.16 ソフトウェアと再現可能性

含める内容:

- 使用ソフトウェア
- パッケージ名とバージョン
- 乱数シード
- コード管理方法
- 再現実行環境
- 出力物の作成方針

### 5.17 原稿と補足資料への接続

含める内容:

- Planned primary tables
- Planned primary figures
- 補足資料の想定
- データ辞書 / コードリスト / アルゴリズム定義の保管先
- 原稿段階で使う報告ガイドライン
- 査読で提示できる付録一覧

### 5.18 SAP 逸脱と変更管理

含める内容:

- SAP からの逸脱をどう定義するか
- 逸脱の記録方法
- 論文本文での報告方針
- 事前計画と事後変更の区別

---

## 6. デザイン別の追加モジュール

## 6.1 RCT・ランダム化比較試験

### 追加すべき事項

- ランダム化方法
- 層別化因子、割付比
- 盲検化の有無
- 介入遵守の定義
- プロトコル逸脱の定義
- ITT、modified ITT、per-protocol の定義
- 中間解析の有無
- 早期中止基準
- 安全性解析
- 多重性調整
- estimand の定義
- 感度分析

### 特に重要な点

- 主解析集団を曖昧にしない
- intercurrent event をどう扱うかを事前に決める
- 複雑デザインでは拡張ガイドラインも併用する

## 6.2 非ランダム化比較・不等価統制群・準実験

### 追加すべき事項

- なぜランダム化できないのか
- 群割付の実際の決まり方
- ベースライン差が生じるメカニズム
- 調整対象の交絡因子
- 交絡因子の選定根拠
- 使用する因果推論法
- overlap / positivity の確認方法
- バランス診断
- 未測定交絡への感度分析

### 特に重要な点

- 群間差が有意でなかった変数だけを共変量に入れる、を避ける
- time zero を揃える
- 主解析法を一つに固定し、他は感度分析と位置づける

## 6.3 因果推論を目的とする観察研究

### 追加すべき事項

- 推定したい因果効果
- 対象集団
- 介入戦略と比較戦略
- ベースライン
- 追跡期間
- 打ち切り
- competing event の扱い
- 因果仮定
- 共変量の選定根拠
- DAG の使用有無
- 因果推定法
- 未測定交絡への感度分析
- negative control の有無

### 特に重要な点

- 単なる回帰式ではなく、因果質問そのものを定義する
- どの集団で、何と何を比べ、どの転帰を、いつ評価し、どの要約量で示すかを明確にする
- target trial emulation を使う場合は、target trial のプロトコル自体を明示する

## 6.4 調査研究・観察研究・縦断調査・コホート研究

### 追加すべき事項

- 研究デザイン
- サンプリング枠
- 抽出法
- 募集方法
- 調査モード
- 測定時点
- 回答率、追跡率の定義
- attrition の扱い
- 重みの使用
- 層化、クラスター化の扱い
- repeated measures の扱い
- 時間変化とカレンダー時点効果の扱い
- 主要記述量、関連推定量
- mixed model / GEE / survival model などの選択理由

### STROBE から借りるべき点

- 対象者選定の透明化
- 変数定義の明確化
- バイアス源の認識
- サンプルサイズの説明
- 統計手法の説明
- 欠測の扱い
- 感度分析

### AAPOR から借りるべき点

- 誰が調査を実施したか
- 対象母集団
- サンプルの作り方
- 調査モード
- 実施日
- 標本サイズ
- 重み付け方法
- データ品質管理
- 限界の認識

## 6.5 routine data / 既存データ研究

### 追加すべき事項

- データベースの性質と収集目的
- データ抽出日、版、更新時点
- 変数の取得可能期間
- 対象者抽出コード、アルゴリズム
- 曝露、アウトカム、共変量のコード一覧
- コードやアルゴリズムの妥当性根拠
- データ連結の方法、成功率、質評価
- データクリーニングの手順
- データ欠落の性質
- 代表性と一般化可能性の限界

### 特に重要な点

- データ源の限界が、そのまま結論の限界になる
- 定義と前処理を見えなくしない
- 開示制約があるなら、その影響まで含めて明示する

## 6.6 既存データを用いたシミュレーション研究

### ADEMP の観点で固定したい項目

- **Aims**
  - 何を評価したいのか
- **Data-generating mechanisms**
  - どんな仮定でデータを発生させるか
- **Estimands**
  - 何を推定対象にするか
- **Methods**
  - 比べる解析法は何か
- **Performance measures**
  - 偏り、平均二乗誤差、被覆率など何を比較するか

### SAP に必須の項目

- 研究目的
- ベースケースと追加シナリオ
- 実データから借りたパラメータと根拠
- 研究者が置いた仮定と理由
- データ生成機構の数式または手順
- 比較する方法の定義
- 性能指標
- 反復回数とその根拠
- Monte Carlo error への配慮
- 乱数シード管理
- 収束失敗や数値エラーの扱い
- 使用ソフトウェアとコード公開方針

### 特に重要な点

- 実データ解析の結果
- 実データから得たパラメータ推定
- その推定を使ったシミュレーション条件
- シミュレーションで得た方法性能

この4つを混ぜないことが重要です。

## 6.7 系統的レビュー / メタアナリシス

### 最低限入れるべき項目

- レビュークエスチョン
- 適格基準
- 情報源と検索戦略
- 選定手順
- データ抽出手順
- リスクオブバイアス評価法
- 効果指標
- データ変換ルール
- どの研究をどの synthesis に入れるかの基準
- 統合モデルの選択と根拠
- 異質性の評価法
- サブグループ解析、メタ回帰の計画
- 感度分析
- 出版バイアス / small-study effects への対応
- certainty の評価法
- どの条件なら統合しないか

### 特に気を付ける点

- どの効果量を優先採用するか
- 複数時点、複数尺度、複数モデルからどれを採るか
- 同一研究の重複報告や重複集団をどう扱うか
- 依存した効果量をどう扱うか
- ゼロイベント研究や要約統計量欠落をどう扱うか
- fixed-effect と random-effects の使い分け
- 異質性が強いとき、統合しない判断をどうするか
- 観察研究のメタアナリシスでは、調整済みと未調整効果量の扱いをどうするか

## 6.8 予測モデル・機械学習研究

### 追加すべき事項

- 予測対象
- 予測時点
- prediction horizon
- intended use
- 開発、内部検証、外部検証の区別
- 学習、検証、テスト分割の方法
- 施設、時期、地域をまたぐ分割か
- データ前処理
- 特徴量選択
- カテゴリエンコーディング
- 正規化、標準化
- ハイパーパラメータ探索
- class imbalance への対処
- leakage 防止
- 欠測処理
- 乱数シード
- 主要評価指標
- 閾値の決め方
- サブグループ性能
- fairness
- モデル更新の有無

### 特に起こりやすい SAP 不備

- テストデータを何度も見て改善してしまう
- 欠測処理を train / test で不整合に行う
- feature engineering に outcome 情報が漏れる
- AUC だけで結論を書く
- calibration を見ない
- 内部検証だけで有用と言う
- 複数モデルを試して一番良いものだけを報告する

## 6.9 質的研究・混合研究法

質的研究では SAP という呼び名が合わないこともありますが、analysis protocol として次を明示すると、後出しの解釈自由度を減らせます。

- データ生成の場面と文脈
- サンプリング方針
- コーディング単位
- 分析手順
- 研究者間確認のやり方
- 反証例の扱い
- 混合研究法なら統合タイミングと統合方法

---

## 7. 実務としての作り方

### Step 1. 研究の問いを一文にする

「結局この研究は何を知りたいのか」を一文で書きます。ここが曖昧なまま SAP を書くと、必ず後でぶれます。

### Step 2. 主解析を一つ決める

主解析を先に決めます。他は副次解析か感度分析か探索的解析に回します。

### Step 3. target quantity を言葉にする

estimand、prediction target、synthesis question、method performance のどれであれ、評価対象を言葉にします。

### Step 4. 変数辞書と mock tables を先に作る

最終的にどの表・図を出したいかを決めると、必要な変数定義や解析が見えやすくなります。

### Step 5. 欠測・外れ値・除外ルールを先に決める

結果を見た後に決めると、恣意性が最も入りやすい部分です。

### Step 6. デザイン固有モジュールを追加する

- RCT ならランダム化、遵守、estimand
- 非ランダム化比較なら交絡、傾向スコア、感度分析
- 縦断研究なら time zero、追跡、脱落
- routine data ならコードリスト、連結、品質
- simulation ならシナリオ、反復数、Monte Carlo error
- meta-analysis なら効果量選択、統合条件、異質性
- prediction なら分割、検証、calibration、fairness

### Step 7. 原稿と査読に耐える付録を先に想定する

- 主要表の雛形
- データ辞書
- コードリスト
- DAG や交絡因子選定表
- 逸脱ログ
- 補足資料の一覧

### Step 8. 主要結果を見る前に version 1.0 を確定する

可能なら、

- データ固定前
- 盲検解除前
- 主要アウトカム集計前
- モデル選択前

の時点で version 1.0 を確定します。

---

## 8. 弱い書き方と強い書き方

### 弱い書き方

- 必要に応じて共変量調整を行う
- 分布に応じて適切な方法を用いる
- 欠測が多い場合には補完を検討する
- サブグループ解析も行う
- 外れ値は適宜処理する

### 強い書き方

- 年齢、性別、施設、ベースライン重症度を主解析で必ず調整する
- 残差診断で前提が崩れた場合は、対数変換またはロバスト推定に切り替える
- 欠測が 5% 未満でも欠測パターンを記述し、主解析は多重代入、完全ケース解析を感度分析とする
- 事前指定のサブグループは性別と年齢層のみとし、交互作用項で検討する
- 外れ値は削除せず、定義済みルールに従って winsorize するかロバスト法で扱う

ここで大事なのは、**コードに落とせる粒度まで書けているか**です。

---

## 9. よくある不備

### 9.1 「適切な方法で解析する」とだけ書く

モデル名、対象集団、共変量、推定量まで書く必要があります。

### 9.2 主要解析が複数ある

本命が何か分からなくなります。

### 9.3 欠測の扱いが「欠測は除外する」だけ

どの変数の欠測をどう扱うか、complete case が許容される根拠は何か、感度分析はするか、まで必要です。

### 9.4 サブグループ解析を思いついただけ全部入れる

主要サブグループだけに絞り、探索的と区別した方が安全です。

### 9.5 因果研究なのに交絡調整の根拠がない

なぜその変数群なのかを明示する必要があります。

### 9.6 予測モデルなのに内部検証しかない

少なくとも内部検証、望ましくは外部検証を考えます。

### 9.7 existing data 研究なのに定義と前処理が見えない

コードリスト、抽出条件、データクリーニング、連結方法を補足資料込みで明示した方がよいです。

### 9.8 シミュレーション研究なのにシナリオ設定の理由がない

各シナリオが、実データ由来なのか、理論的ストレステストなのかを明示します。

### 9.9 メタアナリシスなのに統合方針が後付けに見える

どの効果量を採るか、どのモデルで統合するか、どの条件なら統合しないかを先に書きます。

### 9.10 変更履歴が残っていない

後で「最初からそう決めていたのか」が分からなくなります。

---

## 10. 査読対応に備えるための SAP 運用

査読で強い SAP は、単に内容が細かい SAP ではありません。**なぜその設計判断をしたのかを、事後的に証明できる SAP** です。

### 10.1 事前に残しておくべき記録

- SAP version と確定日
- どの時点で固定したか
- 主要結果を見た後の変更か否か
- 主解析の根拠
- 共変量選定の根拠
- 欠測処理の根拠
- 感度分析の目的
- 逸脱のログ
- 原稿との対応表

### 10.2 査読でよく問われる点

- その解析は本当に事前指定だったのか
- なぜその共変量を調整したのか
- なぜそのモデルを主解析にしたのか
- 欠測、除外、外れ値をどう扱ったのか
- existing data の定義や抽出は信頼できるのか
- simulation の仮定はどこまで実データ由来か
- meta-analysis の効果量選択や統合方針は後付けではないか
- prediction 研究で leakage や過学習をどう防いだか

### 10.3 先回りして用意すると強い付録

- 変数辞書
- データ抽出コード / コードリスト
- DAG または交絡因子選定表
- 主要表の雛形
- 感度分析一覧表
- 診断計画表
- 逸脱と変更ログ
- 報告ガイドラインとの対応表
- 原稿本文に入りきらない技術説明

### 10.4 査読返信での基本姿勢

- 事前指定だったことは、version と日時で示す
- 変更したなら、その理由と影響範囲を説明する
- 変更していないなら、設計上の理由を明示する
- 解析追加をした場合は、事前計画と追加解析を明確に区別する
- レビューアーの懸念が妥当なら、補足資料で透明性を増す

### 10.5 査読対応に強い SAP の特徴

- 主解析が一つに近い
- 主要な自由度が事前に潰されている
- 変更ログが残っている
- 原稿、補足資料、response letter まで見越した構成になっている

---

## 11. 汎用 SAP テンプレート

以下は、研究デザイン横断で使える汎用テンプレートです。不要項目は削除するより、まず `N/A` を入れてから整理する方が安全です。

### 11.1 Core Template

```markdown
# Statistical Analysis Plan

## 1. Administrative information
### 1.1 Title
- Study title:
- SAP title:
- Short title / acronym:

### 1.2 Version control
- SAP version:
- Date:
- Previous versions:
- Summary of changes from previous version:

### 1.3 Related documents
- Protocol title/version/date:
- Registration number / registry:
- Data management plan:
- Other linked documents:

### 1.4 Contributors and approvals
- Lead analyst:
- Senior statistician / methods lead:
- Principal investigator:
- Date of approval:
- Sign-off status:

### 1.5 Timing
- Was this SAP finalized before primary outcome data were inspected?
- Was this SAP finalized before unblinding / final data lock / model selection?
- If not, explain:

## 2. Study overview
### 2.1 Background
- Brief scientific background:
- Practical / policy / theoretical relevance:

### 2.2 Study objective(s)
- Primary objective:
- Secondary objective(s):
- Exploratory objective(s):

### 2.3 Main research question
- One-sentence statement of the main question:

### 2.4 Study design
- Design type:
- Data source:
- Unit of analysis:
- Setting:
- Study period:
- Follow-up period:

## 3. Target quantity / estimand / prediction target / synthesis question
### 3.1 Primary target
- Population:
- Exposure / intervention / comparator:
- Outcome:
- Time horizon:
- Summary measure:
- Interpretation:

### 3.2 Secondary target(s)
- [Repeat as needed]

### 3.3 Confirmatory vs exploratory distinction
- Confirmatory analyses:
- Exploratory analyses:

## 4. Study population and analysis datasets
### 4.1 Eligibility criteria
- Inclusion criteria:
- Exclusion criteria:

### 4.2 Recruitment / sampling / selection
- Sampling frame or recruitment source:
- Enrollment / participation process:
- Flow of participants / records / studies:

### 4.3 Analysis populations / datasets
- Full eligible sample:
- Primary analysis sample:
- Complete-case sample:
- Weighted sample:
- Per-protocol sample (if applicable):
- Development / validation / test sets (if applicable):

### 4.4 Exclusion after data cleaning
- Rules:
- Rationale:
- Whether exclusions are outcome-blind:

## 5. Variable definitions / data items
### 5.1 Primary outcome
- Name:
- Definition:
- Measurement instrument:
- Scale / unit:
- Time point:
- Derived transformation (if any):

### 5.2 Secondary outcomes
- [List and define]

### 5.3 Exposure / intervention / comparator
- Definition:
- Coding:
- Timing:
- Intensity / dose / duration (if relevant):

### 5.4 Covariates / adjustment variables
- List:
- Rationale for inclusion:
- Measurement timing:
- Coding rules:

### 5.5 Subgroup variables / effect modifiers
- List:
- Definitions:
- Rationale:

### 5.6 Derived variables
- Rules for creating composite scores, change scores, categories, lags, rolling averages, etc.

## 6. Timing structure
### 6.1 Baseline / time zero
- Definition of baseline:
- Definition of time zero:

### 6.2 Follow-up
- Start:
- End:
- Censoring rules:
- Competing events:
- Visit windows / analytic windows:

### 6.3 Repeated measures
- Number and timing of repeated assessments:
- Planned handling of within-person correlation:

## 7. Data preprocessing and quality checks
### 7.1 Data cleaning
- Duplicate handling:
- Range checks:
- Logic checks:
- Date consistency checks:

### 7.2 Outliers and influential observations
- Detection rule:
- Main-analysis handling:
- Sensitivity-analysis handling:

### 7.3 Transformations and preprocessing
- Centering / scaling:
- Categorization:
- Winsorization / trimming:
- Feature engineering:
- Leakage prevention procedures (if applicable):

## 8. Descriptive analyses
### 8.1 Sample description
- Variables to summarize:
- Summary statistics:
- Grouped summaries:
- Weighted summaries (if applicable):

### 8.2 Baseline / pre-exposure characteristics
- Planned tables:
- Standardized differences or other balance metrics (if applicable):

## 9. Statistical principles
### 9.1 General principles
- Alpha level:
- Confidence interval level:
- Two-sided or one-sided:
- Multiplicity control:
- Priority of estimation vs hypothesis testing:

### 9.2 Missing data principles
- Main assumption:
- Reporting of missingness:
- Planned handling strategy:
- Sensitivity analyses for missing data:

### 9.3 Model diagnostics and assumption checks
- Linearity:
- Distributional assumptions:
- Proportional hazards:
- Collinearity:
- Positivity / overlap:
- Heterogeneity / influence diagnostics (if meta-analysis):
- Calibration / discrimination (if prediction study):

## 10. Primary analysis
### 10.1 Analysis objective
- Objective addressed by this analysis:

### 10.2 Analysis population
- Dataset:
- Inclusion/exclusion details:

### 10.3 Model specification
- Outcome variable:
- Main predictor / treatment variable:
- Covariates:
- Interaction terms:
- Statistical model:
- Estimation method:
- Variance estimation / robust SE / clustering correction:
- Survey design handling (if applicable):

### 10.4 Effect / performance measures to report
- Measures:
- Format of presentation:
- Planned figures / tables:

## 11. Secondary and additional analyses
### 11.1 Secondary outcome analyses
- [Specify each]

### 11.2 Subgroup / interaction analyses
- Variables:
- Interaction model:
- Planned interpretation:

### 11.3 Supplementary / exploratory analyses
- [Specify]

## 12. Missing data handling
### 12.1 Extent and pattern of missingness
- Planned reporting:

### 12.2 Main handling strategy
- Complete case / multiple imputation / inverse probability weighting / model-based handling / other:
- Variables included in imputation model:
- Number of imputations:
- Compatibility between imputation and substantive model:

### 12.3 Sensitivity analyses for missingness
- [Specify]

## 13. Sensitivity / robustness analyses
- Alternative covariate adjustment set:
- Alternative sample restrictions:
- Alternative operationalization of exposure or outcome:
- Alternative model form:
- Alternative time-zero definition:
- Quantitative bias analysis / unmeasured confounding sensitivity:
- Alternative random seeds / resampling plans (if applicable):

## 14. Design-specific module
- RCT module attached? yes/no
- Nonrandomized comparative / causal module attached? yes/no
- Survey / longitudinal / cohort module attached? yes/no
- Routine data module attached? yes/no
- Simulation module attached? yes/no
- Evidence synthesis module attached? yes/no
- Prediction model module attached? yes/no
- Qualitative / mixed methods module attached? yes/no

## 15. Software and reproducibility
- Software:
- Package versions:
- Random seed:
- Code repository:
- Reproducible workflow notes:

## 16. Deviations from SAP
- Rules for documenting deviations:
- Who approves deviations:
- How deviations will be reported in manuscripts:

## 17. Outputs and manuscript linkage
- Planned primary tables:
- Planned primary figures:
- Supplementary materials:
- Code lists / appendices to prepare:
- Reporting checklist(s) to use at manuscript stage:

## 18. References and appendices
- References:
- Appendices:
```

### 11.2 RCT Module

```markdown
## RCT Module
### R1. Randomization
- Allocation ratio:
- Randomization method:
- Stratification / minimization factors:
- Allocation concealment:

### R2. Blinding
- Who is blinded:
- Conditions for unblinding:

### R3. Adherence and protocol deviations
- Definition of adherence:
- Definition of protocol deviation:
- Summary rules:

### R4. Analysis populations
- ITT:
- Modified ITT:
- Per-protocol:
- Safety population:

### R5. Intercurrent events / estimand
- Relevant intercurrent events:
- Strategy for each intercurrent event:
- Main estimand:
- Sensitivity estimand(s):

### R6. Interim analyses
- Whether planned:
- Timing:
- Alpha spending / stopping rules:
```

### 11.3 Nonrandomized Comparative / Causal Module

```markdown
## Nonrandomized Comparative / Causal Module
### C1. Treatment assignment mechanism
- How exposure / intervention is assigned in practice:
- Why confounding is expected:

### C2. Causal question
- Target causal contrast (ATE / ATT / other):
- Population:
- Intervention strategy:
- Comparator strategy:
- Follow-up:
- Outcome:

### C3. Confounding control
- Candidate confounders:
- Rationale for confounder selection:
- Data source and timing for each confounder:

### C4. Causal identification assumptions
- Consistency:
- Exchangeability / no unmeasured confounding:
- Positivity:
- Model assumptions:

### C5. Estimation strategy
- Regression adjustment / PS matching / IPTW / overlap weighting / g-computation / doubly robust / TMLE / DiD / ITS / RDD / synthetic control:
- Primary method:
- Alternative methods for sensitivity analyses:

### C6. Diagnostics
- Covariate balance:
- Positivity / overlap:
- Weight truncation / stabilization:
- Time-zero alignment:
- Negative controls / falsification tests:
```

### 11.4 Survey / Longitudinal / Cohort Module

```markdown
## Survey / Longitudinal / Cohort Module
### S1. Sampling and recruitment
- Sampling frame:
- Probability / nonprobability sampling:
- Recruitment procedures:
- Eligibility screening:
- Incentives:

### S2. Survey administration
- Mode(s):
- Language(s):
- Field dates:
- Instrument details:
- Quality checks:

### S3. Weights and design effects
- Weight construction:
- Post-stratification / calibration:
- Clustering:
- Stratification:
- Finite population correction (if applicable):

### S4. Longitudinal structure
- Waves / visits:
- Attrition definitions:
- Retention rules:
- Time-varying covariates:
- Time-varying exposures:

### S5. Primary analysis model
- Cross-sectional / longitudinal / survival / multilevel / GEE / mixed effects:
- Correlation structure:
- Handling of repeated measures:
```

### 11.5 Routine Data Module

```markdown
## Routine Data Module
### D1. Data source and provenance
- Database name:
- Version / extraction date:
- Original purpose of data collection:
- Coverage and known limitations:

### D2. Case selection and coding
- Eligibility algorithm:
- Exposure code list:
- Outcome code list:
- Covariate code list:
- Validation references:

### D3. Linkage
- Whether data linkage was used:
- Linkage method:
- Linkage success rate:
- Linkage quality assessment:

### D4. Data quality
- Missingness vs non-capture distinction:
- Cleaning rules:
- Duplicate handling:
- Date consistency checks:
```

### 11.6 Simulation Module

```markdown
## Simulation Module
### M1. Aims
- Main methodological question:
- Target estimand:

### M2. Data-generating mechanisms
- Baseline scenario:
- Additional scenarios:
- Parameters borrowed from real data:
- Investigator-imposed assumptions:

### M3. Methods compared
- Candidate methods:
- Tuning rules:
- Convergence criteria:

### M4. Performance measures
- Bias:
- RMSE / MSE:
- Coverage:
- Type I error / power:
- Calibration / discrimination (if relevant):

### M5. Simulation execution
- Number of repetitions:
- Monte Carlo error plan:
- Random seed management:
- Handling of failures / non-convergence:
```

### 11.7 Evidence Synthesis Module

```markdown
## Evidence Synthesis Module
### E1. Review question and eligibility
- Review question:
- Inclusion criteria:
- Exclusion criteria:

### E2. Search and selection
- Information sources:
- Search strategy:
- Screening process:
- Handling of duplicate reports:

### E3. Data extraction and risk of bias
- Extraction fields:
- Extraction process:
- Risk-of-bias tool:
- Disagreement resolution:

### E4. Effect size and synthesis
- Preferred effect size:
- Transformation rules:
- Model choice:
- Conditions under which synthesis will not be performed:

### E5. Heterogeneity and additional analyses
- Heterogeneity metrics:
- Subgroup analyses:
- Meta-regression:
- Sensitivity analyses:
- Publication bias / small-study effects:
- Certainty assessment:
```

### 11.8 Prediction Model / Machine Learning Module

```markdown
## Prediction Model / Machine Learning Module
### P1. Prediction objective
- Diagnostic / prognostic / screening / monitoring:
- Prediction horizon:
- Intended use:
- Decision context:

### P2. Dataset partitioning
- Development set:
- Internal validation method:
- Test set:
- External validation dataset:
- Temporal / geographic / institutional split:

### P3. Preprocessing
- Missing-data handling:
- Feature encoding:
- Scaling / normalization:
- Feature selection:
- Leakage prevention:

### P4. Model development
- Candidate algorithms:
- Hyperparameter tuning strategy:
- Resampling strategy:
- Class imbalance handling:
- Early stopping / regularization:

### P5. Performance evaluation
- Discrimination metrics:
- Calibration metrics:
- Overall accuracy metrics:
- Clinical utility metrics:
- Threshold selection:
- Subgroup performance:
- Fairness assessment:

### P6. Model reporting and release
- Final model specification:
- Probability output / score output:
- Code availability:
- Model updating / recalibration plan:
```

### 11.9 Qualitative / Mixed Methods Module

```markdown
## Qualitative / Mixed Methods Module
### Q1. Data generation context
- Setting:
- Participants:
- Sampling strategy:
- Data collection method:

### Q2. Analytic approach
- Coding unit:
- Analytic framework:
- Steps of analysis:
- Researcher reflexivity notes:

### Q3. Quality and validation
- Multiple-coder procedures:
- Negative case analysis:
- Member checking / audit trail:

### Q4. Integration (for mixed methods)
- Timing of integration:
- Points of interface between qualitative and quantitative strands:
- Integration products:
```

---

## 12. 参考文献・主要ガイドライン

1. Gamble C, Krishan A, Stocken D, et al. *Guidelines for the Content of Statistical Analysis Plans in Clinical Trials*. JAMA. 2017;318(23):2337-2343.
2. DeMets DL, Cook TD, Buhr KA. *Guidelines for Statistical Analysis Plans*. JAMA. 2017;318(23):2301-2303.
3. International Conference on Harmonisation (ICH). *E9 Statistical Principles for Clinical Trials*. 1998.
4. ICH. *E9(R1) Addendum on Estimands and Sensitivity Analysis in Clinical Trials*. Step 5, effective 2020.
5. STROBE Statement. *Strengthening the Reporting of Observational Studies in Epidemiology*. https://www.strobe-statement.org/
6. Benchimol EI, Smeeth L, Guttmann A, et al. *The REporting of studies Conducted using Observational Routinely-collected health Data (RECORD) Statement*. PLoS Medicine. 2015;12(10):e1001885.
7. RECORD Statement. *RECORD Reporting Guidelines*. https://www.record-statement.org/
8. Langan SM, Schmidt SAJ, Wing K, et al. *The reporting of studies conducted using observational routinely collected health data statement for pharmacoepidemiology (RECORD-PE)*. BMJ. 2018;363:k3532.
9. CDC. *TREND Statement*. https://www.cdc.gov/hivpartners/php/trend-statement/index.html
10. Matthews AA, Danaei G, Islam N, Kurth T. *Target trial emulation: applying principles of randomised trials to observational studies*. BMJ. 2022;378:e071108.
11. Cashin AG, Hansford HJ, Hernán MA, et al. *Transparent reporting of observational studies emulating a target trial: the TARGET Statement*. BMJ. 2025;390:e087179.
12. TRIPOD+AI. *Updated guidance for reporting clinical prediction models that use regression or machine learning methods*. BMJ. 2024;385:e078378.
13. Wolff RF, Moons KGM, Riley RD, et al. *PROBAST: A Tool to Assess the Risk of Bias and Applicability of Prediction Model Studies*. Annals of Internal Medicine. 2019;170(1):51-58.
14. Moons KGM, Damen JAA, Kaul T, et al. *PROBAST+AI*. BMJ. 2025;388:e082505.
15. AAPOR. *Disclosure Standards / Transparency Initiative*. https://aapor.org/standards-and-ethics/disclosure-standards/
16. Lang T, Altman D. *SAMPL Guidelines*. https://www.equator-network.org/reporting-guidelines/sampl/
17. Page MJ, McKenzie JE, Bossuyt PM, et al. *The PRISMA 2020 statement: an updated guideline for reporting systematic reviews*. BMJ. 2021;372:n71.
18. PRISMA Statement. *PRISMA-Protocols (PRISMA-P)*. https://www.prisma-statement.org/protocols
19. Deeks JJ, Higgins JPT, Altman DG, McKenzie JE, Veroniki AA, et al. *Chapter 10: Analysing data and undertaking meta-analyses*. In: Cochrane Handbook for Systematic Reviews of Interventions version 6.5. Cochrane; 2024.
20. Stroup DF, Berlin JA, Morton SC, et al. *Meta-analysis of observational studies in epidemiology: a proposal for reporting*. JAMA. 2000;283(15):2008-2012.
21. Morris TP, White IR, Crowther MJ. *Using simulation studies to evaluate statistical methods*. Statistics in Medicine. 2019;38(11):2074-2102.
22. Koehler E, Brown E, Haneuse SJP-A. *On the Assessment of Monte Carlo Error in Simulation-Based Statistical Analyses*. The American Statistician. 2009;63(2):155-162.
23. ICMJE. *Preparing a Manuscript for Submission to a Medical Journal*. https://www.icmje.org/recommendations/browse/manuscript-preparation/preparing-for-submission.html
24. EQUATOR Network. *Reporting guidelines*. https://www.equator-network.org/reporting-guidelines/
25. Appelbaum M, Cooper H, Kline RB, Mayo-Wilson E, Nezu AM, Rao SM. *Journal article reporting standards for quantitative research in psychology*. American Psychologist. 2018;73(1):3-25.
26. Levitt HM, Bamberg M, Creswell JW, Frost DM, Josselson R, Suárez-Orozco C. *Journal article reporting standards for qualitative primary, qualitative meta-analytic, and mixed methods research in psychology*. American Psychologist. 2018;73(1):26-46.
27. Association for Psychological Science. *Preregistration of Research Plans*. https://www.psychologicalscience.org/publications/journals/psychological_science/preregistration
28. Open Science Framework. *OSF*. https://osf.io/about/

---

## 13. ひとことでまとめると

**良い SAP は、「あとで説明できる分析」ではなく、「先に説明してから実行する分析」を支える文書**です。

単一の万能ガイドラインを探すより、

- JAMA 2017 の SAP 骨格
- ICH E9(R1) の問いと解析の整合
- STROBE / RECORD / TREND / TARGET / TRIPOD+AI / PRISMA などのデザイン固有指針
- ROBINS-I / PROBAST(+AI) などの、後で突っ込まれる点の先回り

を組み合わせる方が、ずっと実務的で強いです。
