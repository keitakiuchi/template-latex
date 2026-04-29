# General Statistical Analysis Plan Guide

## 汎用版SAP（Statistical Analysis Plan）作成ガイド
### RCT、非ランダム化比較、不等価統制群、因果推論、観察研究、縦断・コホート調査、機械学習予測モデル研究に対応

---

## 0. まず結論

Statistical Analysis Plan（SAP）は、**「どのデータを、どのルールで、どの目的で、どう分析するか」を、結果を見る前にできるだけ具体的に固定する文書**です。  
目的は主に次の4つです。

1. **恣意性を減らすこと**  
   結果を見てから都合のよい解析に切り替えることを防ぎます。

2. **再現性を高めること**  
   別の研究者が同じルールで解析を追試しやすくなります。

3. **研究目的と解析の整合を保つこと**  
   研究で本当に答えたい問いと、実際の統計解析がずれにくくなります。

4. **査読・共同研究・将来の自分への説明責任を果たすこと**  
   「なぜその分析をしたのか」を後から説明しやすくなります。

大事な点は、**臨床試験ではSAPの正式ガイドラインが比較的整っていますが、研究デザイン全体を貫く単一の“万能SAPガイドライン”はまだ存在しない**、ということです。  
したがって、実務上は次の考え方がもっとも使いやすいです。

- **共通コア**（どの研究にも必要なSAPの骨格）を作る
- その上に、研究デザインごとの**追加モジュール**を載せる
- さらに、必要に応じて**報告ガイドライン**や**リスク・オブ・バイアス評価ツール**を逆算的に利用する

この文書では、そのための**汎用SAPの書き方**を、既存ガイドラインの内容も踏まえて整理します。

---

## 1. SAPとは何か

### 1-1. 定義
ICH E9では、SAPは**プロトコルに書かれた解析の主要事項を、より技術的かつ詳細に具体化した文書**として位置づけられています。  
つまり、プロトコルが「何を検証するか」の全体設計を示すのに対して、SAPは「それを統計的にどう実行するか」の実施仕様書に近い文書です。

### 1-2. SAP、プロトコル、事前登録（preregistration）の違い
混同しやすいので、ここは分けて考えると整理しやすいです。

- **プロトコル**
  - 研究背景、目的、デザイン、対象者、測定、倫理、運営などを含む全体計画書
- **SAP**
  - 主に統計解析の事前計画を詳しく書く文書
  - 解析対象集団、変数定義、主解析、副次解析、欠測処理、感度分析などを詳しく書く
- **事前登録（preregistration）**
  - 研究計画や解析計画を、タイムスタンプ付きで登録する実践
  - SAPそのものを登録してもよいし、SAPを要約した登録でもよい

### 1-3. SAPは独立文書でなければならないか
必ずしもそうではありません。  
臨床試験では独立文書として作成されることが多いですが、**研究の規模や分野によっては、プロトコル付録・登録文書・解析計画書として統合されていても構いません**。  
重要なのは形式よりも、次の3点です。

- **結果を見る前にできるだけ固定されていること**
- **版管理（version control）がされていること**
- **変更理由が追跡できること**

---

## 2. ガイドラインの地図：何があり、何がないか

## 2-1. もっとも明確なSAP内容ガイドラインは臨床試験領域にある
臨床試験では、Gambleら（JAMA, 2017）が**55項目**からなるSAP内容ガイドラインを提示しました。  
これは現在でも、SAPの「骨格」を考えるうえで最も実務的な出発点のひとつです。

その内容は大きく6領域に整理されています。

- **Administrative information（管理情報）**
- **Introduction（背景・目的）**
- **Study methods（研究方法）**
- **Statistical principles（統計原則）**
- **Study population / trial population（解析対象集団）**
- **Analysis（解析内容）**

この構造は、臨床試験以外にもかなり流用できます。  
ただし、試験特有の項目（ランダム化、割付、ハームなど）は、他デザインでは読み替えが必要です。

## 2-2. 非臨床試験領域には「SAPそのもの」の統一ガイドラインは少ない
ここが重要です。  
観察研究、調査研究、因果推論、予測モデル研究では、**論文報告ガイドライン**や**バイアス評価ツール**は豊富ですが、SAP専用の統一ガイドラインは少ないです。

したがって、非臨床試験では次のように考えるのが実務的です。

- **SAPの骨格**は JAMA 2017 / ICH E9 の発想を借りる
- **デザイン固有の要求事項**は STROBE / RECORD / TREND / TARGET / TRIPOD+AI などから足す
- **後で問題になるバイアス**は ROBINS-I / PROBAST / PROBAST+AI から逆算して、SAP段階で先回りして書く

## 2-3. 使い分けの目安
### RCTや比較試験
- JAMA SAPガイドライン
- ICH E9 / E9(R1)
- SPIRIT / CONSORT とその拡張

### 非ランダム化比較、不等価統制群、準実験
- TREND
- ROBINS-I
- 必要なら TARGET（target trial emulation を使う場合）

### 観察研究、縦断研究、コホート研究
- STROBE
- RECORD（ルーチンデータ、レジストリ、電子カルテなどを使う場合）
- 調査なら AAPOR disclosure standards

### 因果推論
- ICH E9(R1) の **estimand**（エスティマンド：何を推定したいかを明確にする枠組み）の考え方
- Target trial framework
- TARGET（2025）

### 機械学習の予測モデル研究
- TRIPOD+AI
- PROBAST / PROBAST+AI
- 必要なら SAMPL（統計報告の基本）

---

## 3. 汎用SAPの基本原則
デザインが違っても、良いSAPには共通する原則があります。

### 3-1. 研究の「問い」を統計量に落とす
研究の問いが曖昧だと、解析も曖昧になります。  
SAPでは、研究の問いを少なくとも次のいずれかに落とし込みます。

- **因果効果**（例：介入AはBより抑うつ得点をどれだけ減らすか）
- **記述量**（例：有病率、平均値、分布）
- **関連の強さ**（例：暴露と転帰の関連）
- **予測性能**（例：6か月後離職の予測精度）

### 3-2. 確証的解析と探索的解析を分ける
これは全デザインで重要です。

- **確証的解析**  
  事前に主要な問い・主要解析として固定する解析
- **探索的解析**  
  結果を見てから発見的に行う解析、追加の仮説生成のための解析

両者を混ぜると、読者も査読者も解釈に困ります。  
SAPでは、**どこまでが事前規定で、どこからが探索か**をはっきり書きます。

### 3-3. 解析対象集団・除外ルールを結果の前に固定する
「誰を解析に含めるか」は結果を大きく左右します。  
したがって、少なくとも以下を事前に定義します。

- 対象者選定基準
- 除外基準
- 欠測や脱落があったときの扱い
- 外れ値の扱い
- データクリーニング後にどのデータセットを本解析に使うか

### 3-4. 変数定義を曖昧にしない
変数定義が曖昧だと、同じデータでも別の解析になります。  
最低限、次を具体化します。

- 主要アウトカム
- 副次アウトカム
- 暴露・介入・比較群
- 共変量（調整変数）
- 派生変数（例：変化量、カテゴリ化変数、合成指標）
- 測定時点
- 単位、尺度、変換ルール

### 3-5. 主解析モデルを一意に近づける
「適切な回帰分析を行う」では不十分です。  
できるだけ次を具体的に書きます。

- どのモデルを使うか
- 何を従属変数にするか
- 主要な独立変数は何か
- どの共変量を強制投入するか
- 交互作用を見るか
- クラスタリングや反復測定をどう扱うか
- どの推定量を報告するか（回帰係数、オッズ比、ハザード比、平均差、C統計量など）

### 3-6. 感度分析を最初から組み込む
感度分析とは、**前提や分析選択が変わったときに結論がどれくらい変わるかを確認する解析**です。  
よいSAPは、主解析だけで終わりません。

### 3-7. 変更履歴を残す
SAPは一度も変更してはいけない文書ではありません。  
ただし変更するなら、

- いつ
- 誰が
- なぜ
- データをどの程度見た後か
- 主解析に影響するか

を記録する必要があります。

---

## 4. 汎用SAPの推奨構成
以下は、臨床試験SAPの骨格をベースに、非臨床試験にも流用できるよう一般化した構成です。  
**使わない項目は消すのではなく、N/A（該当なし）と理由を書く**と透明性が高まります。

### 4-1. 管理情報（Administrative information）
ここは軽視されがちですが、実務ではかなり重要です。

含める内容：
- 文書タイトル
- SAP version と日付
- 関連するプロトコルや登録番号
- 作成者、解析責任者、承認者
- 改訂履歴
- 改訂理由
- データ固定前か後か
- 主要結果を見た後の変更か否か

### 4-2. 背景と研究目的
含める内容：
- 研究の背景
- 実務・理論・政策上の意義
- 研究目的
- 主要仮説
- 副次仮説
- 探索的問い

### 4-3. 研究デザインとデータソース
含める内容：
- 研究デザイン（RCT、非ランダム化比較、前後比較、縦断、コホート、横断、症例対照、予測モデル開発、外的検証など）
- データソース（新規収集、既存データ、電子カルテ、レジストリ、質問紙、公開データなど）
- データ収集時期
- 分析単位（人、施設、クラスター、時点など）
- 追跡期間
- 介入や暴露の定義

### 4-4. 研究対象と解析対象
含める内容：
- 適格基準
- 除外基準
- 登録・参加フロー
- 解析対象集団の定義
- 主解析集団
- 完全ケース解析集団
- 感度分析用集団
- 予測モデルなら開発用・検証用・外的検証用データセットの定義

### 4-5. 主要変数の定義
含める内容：
- 主要アウトカム
- 副次アウトカム
- 暴露・介入・比較群
- 共変量
- 層別変数
- サブグループ変数
- 派生変数の作成ルール
- 測定尺度
- 単位
- 収集時点
- データ辞書への参照

### 4-6. 解析タイミングと time zero
特に因果推論・縦断研究・比較研究で重要です。

含める内容：
- ベースラインの定義
- 追跡開始時点（time zero）
- 追跡終了条件
- 解析時点
- 解析ウィンドウ
- 反復測定の扱い
- 打ち切り（censoring）のルール

### 4-7. データ前処理・クリーニング
含める内容：
- データチェックの範囲
- 論理矛盾の扱い
- 外れ値の検出ルール
- 値域外データの処理
- 日付不整合の処理
- 重複レコードの処理
- 派生変数作成の順序
- 予測モデルなら leakage（リーケージ：本来使ってはいけない情報が学習に混入すること）防止策

### 4-8. 記述統計
含める内容：
- どの変数を記述するか
- 連続変数の要約方法（平均/標準偏差、中央値/四分位範囲など）
- カテゴリ変数の要約方法
- 群別に出すか
- 縦断データなら時点別に出すか
- サンプルサイズの示し方
- 調査研究なら重み付き推定を使うか

### 4-9. 統計原則
含める内容：
- 有意水準
- 信頼区間
- 多重性の扱い
- 片側/両側検定
- 効果量の優先
- 近似ではなく推定量中心で報告するか
- モデル仮定の確認方法
- 必要ならベイズ解析の事前分布

### 4-10. 主解析
ここがSAPの中核です。  
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

### 4-11. 副次解析・追加解析
含める内容：
- 副次アウトカム解析
- サブグループ解析
- 交互作用解析
- メディエーション（媒介）解析
- モデレーション解析
- 補足解析
- exploratory analysis として扱う解析

### 4-12. 欠測データの扱い
欠測の記述が曖昧なSAPはとても多いです。  
最低限、以下が必要です。

- 欠測の種類
- 欠測の量をどう報告するか
- 主解析での扱い
- 多重代入を使うか
- 代入モデルに入れる変数
- complete case を使うなら、その理由
- 追跡脱落や検査未実施をどう扱うか
- 予測モデルでの欠測処理（単純代入、モデル内処理、学習/評価での整合性）

### 4-13. 感度分析・ロバストネス分析
含める候補：
- 欠測処理の別法
- 共変量セットの変更
- time zero の変更
- 外れ値処理の変更
- 解析対象集団の変更
- 傾向スコア法の別仕様
- 未測定交絡に対する感度分析
- 予測モデルなら閾値、キャリブレーション、別データ分割、別乱数シード

### 4-14. 仮定の確認と診断
含める内容：
- 線形性の確認
- 正規性の確認
- 比例ハザード性の確認
- 多重共線性
- 残差診断
- overlap/positivity の確認
- 共変量バランス
- 予測モデルなら calibration / discrimination / overfitting / fairness の診断

### 4-15. ソフトウェアと再現可能性
含める内容：
- 使用ソフトウェア
- パッケージ名とバージョン
- 乱数シード
- コード管理方法
- 再現実行環境
- 出力物（表・図・付録）の作成方針

### 4-16. SAP逸脱と変更管理
含める内容：
- SAPからの逸脱をどう定義するか
- 逸脱の記録方法
- 論文本文での報告方針
- 事前計画と事後変更の区別

---

## 5. デザイン別の追加モジュール

## 5-1. RCT・ランダム化比較試験
RCTでは、JAMA 2017 のSAPガイドラインと ICH E9 / E9(R1) が中核です。  
特に次を追加して書くと、汎用SAPが一気に実務的になります。

### 追加すべき事項
- ランダム化方法
- 層別化因子・割付比
- 盲検化の有無
- 介入遵守（adherence）の定義
- プロトコル逸脱の定義
- ITT（intention-to-treat：割付時点の群で解析する考え方）と per-protocol の定義
- 中間解析の有無
- 早期中止基準
- 安全性解析
- 多重性調整
- estimand の定義
- 感度分析

### RCTで特に重要な点
1. **主解析集団を曖昧にしない**  
   ITTにするのか、modified ITTにするのか、per-protocolにするのかを明示します。

2. **estimand を明確にする**  
   ICH E9(R1) 以降は、「何を推定したいか」をより厳密に書くことが求められます。  
   たとえば、治療中止や救済治療のような**intercurrent event**（介入後に起こって、効果解釈に影響する事象）をどう扱うかを事前に決めます。

3. **複雑デザインでは拡張ガイドラインを併用する**  
   クラスターRCT、非劣性試験、適応デザイン、ステップウェッジ、routine dataを用いたRCTなどは、CONSORT / SPIRIT の拡張も参照した方が安全です。

---

## 5-2. 不等価統制群を用いた比較試験・非ランダム化比較・準実験
ここでは、割付がランダムでないため、**交絡（こんらん：比較群の違いが介入効果と混ざること）**が本質的な課題になります。  
したがってSAPには、**比較可能性をどう確保するか**をより明確に書く必要があります。

### 追加すべき事項
- なぜランダム化できないのか
- 群割付の実際の決まり方
- ベースライン差が生じるメカニズム
- 調整対象の交絡因子
- 交絡因子の選定根拠
- 使用する因果推論法
  - 回帰調整
  - 傾向スコアマッチング
  - IPTW（inverse probability of treatment weighting：逆確率重み付け）
  - overlap weighting
  - difference-in-differences
  - interrupted time series
  - regression discontinuity
  - synthetic control
- overlap/positivity の確認方法
- バランス診断
- 未測定交絡への感度分析

### ここで特に重要な点
1. **「群間差が有意でなかった変数だけを共変量に入れる」は避ける**  
   共変量選定は、原則として理論・先行研究・因果図・設計上の知見に基づいて行います。

2. **time zero を揃える**  
   介入群と比較群で追跡開始点がずれると、重大なバイアス（例：immortal time bias）が入ります。

3. **主解析を1つに固定する**  
   傾向スコア法を何種類も試して一番都合のよいものを採用すると、事後的な解析選択になります。  
   主解析法を先に固定し、他は感度分析として位置づけます。

### 参照しやすいガイドライン
- TREND（非ランダム化評価の報告）
- ROBINS-I（非ランダム化介入研究のバイアス評価）
- 必要に応じて TARGET（target trial を明示的にエミュレートする場合）

---

## 5-3. 因果推論を目的とする観察研究
因果推論では、「関連があるか」だけでなく、**もし介入Aを受けたらどうなるか**という反事実的な問いを扱います。  
そのためSAPでは、単なる回帰式よりも、**因果質問の定義**が重要です。

### 追加すべき事項
- 推定したい因果効果
  - ATE（average treatment effect：集団平均効果）
  - ATT（average treatment effect on the treated：処置群平均効果）
  - risk difference, risk ratio, hazard ratio など
- 対象集団
- 介入戦略と比較戦略
- ベースライン
- 追跡期間
- 打ち切り
- competing event（競合事象）の扱い
- 因果仮定
  - consistency
  - exchangeability / no unmeasured confounding
  - positivity
  - model specification
- 共変量の選定根拠
- DAG（Directed Acyclic Graph：因果関係の仮説図）の使用有無
- 因果推定法
  - g-computation
  - IPTW
  - doubly robust estimation
  - TMLE など
- 未測定交絡への感度分析
- negative control の有無

### ICH E9(R1) の考え方をどう一般化するか
ICH E9(R1) は臨床試験向けですが、**「何を推定したいのかを、解析前に言語化する」**という estimand の考え方は、因果推論全般に非常に相性がよいです。  
臨床試験以外では、厳密に「estimand」という言葉を使わなくても、少なくとも以下を明確にするとかなり整理されます。

- どの集団で
- 何と何を比べ
- どの転帰を
- いつ評価し
- どの要約量で示すか

### target trial emulation を使う場合
2025年の TARGET statement は、**target trial を明示的にエミュレートする観察研究**の報告ガイドラインです。  
SAPにも非常に使いやすい考え方を含んでいます。特に重要なのは次です。

- target trial の**プロトコル自体**を明示すること
- その各要素を**観察データにどう写像したか**を書くこと
- 因果 estimand、仮定、データ解析計画を明記すること
- 推定値だけでなく、仮定や設計選択に対する感度分析も示すこと

これは、因果推論SAPの質をかなり上げます。

---

## 5-4. 調査研究、観察研究、縦断調査、コホート研究
この領域では、SAP専用ガイドラインよりも、STROBEやAAPORなどの**報告・開示基準**が役立ちます。  
SAPでは、それらを「分析前に固定すべき情報」として逆算して取り込みます。

### 追加すべき事項
- 研究デザイン（横断・縦断・コホート・症例対照）
- サンプリング枠
- 抽出法
- 募集方法
- 調査モード（Web, 郵送, 面接, 電話など）
- 測定時点
- 回答率・追跡率の定義
- attrition（脱落）の扱い
- 重み（survey weights）の使用
- 層化・クラスター化の扱い
- repeated measures の扱い
- 時間変化とカレンダー時点効果の扱い
- 主要記述量・関連推定量
- 縦断データなら mixed model, GEE, survival model などの選択理由

### STROBEからSAPに活かせる点
STROBEは観察研究の報告ガイドラインですが、SAPを書くときにも次の点が役立ちます。

- 対象者選定の透明化
- 変数定義の明確化
- バイアス源の認識
- サンプルサイズの説明
- 統計手法の説明
- 欠測の扱い
- 感度分析の記載

### RECORDが必要な場面
次のようなデータなら、RECORDを意識した方がよいです。

- 電子カルテ
- 保険請求データ
- レジストリ
- 行政データ
- routine data

これらでは、コードリスト、アルゴリズム定義、データリンク、データ品質の問題が重要になるため、SAPでも以下を書いておくと強いです。

- 変数抽出アルゴリズム
- コード体系（ICD, Read, SNOMED など）
- リンク方法
- データ源ごとの差異
- 妥当性確認の有無

### 調査研究でAAPORから借りるべき要素
AAPORの disclosure standards は、特に調査研究で役立ちます。  
SAPや関連文書に次を入れておくと、報告時に困りにくいです。

- 誰が調査を実施したか
- 対象母集団
- サンプルの作り方
- 調査モード
- 実施日
- 標本サイズ
- 重み付け方法
- データ品質管理
- 限界の認識

---

## 5-5. 機械学習の予測モデル研究
ここでは最初に、**予測研究と因果研究は目的が違う**と明記しておくと、SAPがぶれにくいです。

- **因果研究**：介入の効果を知りたい
- **予測研究**：将来や未知データでの予測精度を高めたい

予測モデル研究のSAPでは、推定量よりも**モデル開発・評価手順の固定**がとても重要です。

### 追加すべき事項
- 予測対象（何を予測するか）
- 予測時点
- 予測 horizon（何日後、何か月後、何年後か）
- intended use（何の意思決定に使うか）
- 開発・内部検証・外部検証の区別
- 学習・検証・テスト分割の方法
- 施設・時期・地域をまたぐ分割か
- データ前処理
- 特徴量選択
- カテゴリエンコーディング
- 正規化・標準化
- ハイパーパラメータ探索
- class imbalance の対処
- leakage 防止
- 欠測処理
- 乱数シード
- 主要評価指標
  - discrimination（識別能）
  - calibration（較正）
  - overall accuracy
  - clinical utility
- 閾値の決め方
- サブグループ性能
- fairness（公平性）
- モデル更新（updating / recalibration）の有無

### TRIPOD+AIからSAPに活かせる点
TRIPOD+AIは、回帰モデルにも機械学習にも対応する**27項目**の報告ガイドラインで、TRIPOD-2015 を置き換えました。  
SAPに活かしやすいのは次の点です。

- 研究の目的が**開発**なのか**評価（検証）**なのかを分ける
- 予測対象・予測時点・対象集団を明確にする
- データ分割や検証手順を明示する
- モデル性能を複数側面から評価する
- オープンサイエンス（プロトコル、登録、データ共有、コード共有）を意識する
- subgroup / fairness の性能を検討する

### PROBAST / PROBAST+AIからSAPに活かせる点
PROBASTは予測モデル研究のバイアス評価ツールです。  
4つの領域を見ます。

- participants
- predictors
- outcome
- analysis

PROBAST+AI では、回帰・AIの両方に対応するかたちで更新されました。  
SAP段階では、少なくとも次を先回りして書いておくと、後で「analysis domain が高リスク」と言われにくくなります。

- サンプルサイズとイベント数の妥当性
- 過学習への対策
- 内部検証の方法
- 外部検証の有無
- 欠測処理
- キャリブレーション評価
- data leakage 防止
- fairness とアルゴリズムバイアスへの配慮

### 機械学習予測研究で特に起こりやすいSAP不備
- テストデータを何度も見てモデル改善してしまう
- 欠測処理を train/test で不整合に行う
- feature engineering に outcome 情報が漏れる
- AUC だけで結論を書く
- calibration を見ない
- 内部検証だけで「有用」と言ってしまう
- 複数モデルを試して一番良いものだけを報告する

これらは、SAP段階でかなり防げます。

---

## 6. SAPに必ず入れたい「研究デザインをまたいだ共通項目」チェックリスト
以下は、分野が違ってもほぼ必須です。

- 研究目的が1文で言える
- 主要な問いが1つに絞られている
- 主要解析が1つに近い形で固定されている
- 主要アウトカムが明確
- 主要暴露・介入・比較が明確
- 解析対象集団が明確
- 除外基準が明確
- 欠測の扱いが明確
- モデルと推定量が明確
- 効果量や性能指標の提示形式が明確
- 感度分析が事前に決まっている
- confirmatory と exploratory が区別されている
- 変更履歴を残す方法が決まっている
- ソフトウェアとバージョンが決まっている

---

## 7. 実務としての書き方：おすすめの作成手順

### Step 1. 研究の問いを1文にする
最初に、「結局この研究は何を知りたいのか」を1文で書きます。  
この1文が曖昧なままSAPを書くと、必ず後でぶれます。

### Step 2. 主要解析を1つ決める
主解析を先に決めます。  
他は副次解析か感度分析か探索的解析に回します。

### Step 3. 変数辞書とモック表を先に作る
**最終的にどの表・図を出したいか**を決めると、必要な変数定義や解析が見えやすくなります。

### Step 4. 欠測・外れ値・除外ルールを先に決める
結果を見た後に決めると、もっとも恣意性が入りやすい部分です。

### Step 5. デザイン固有モジュールを追加する
- RCTならランダム化・遵守・estimand
- 非ランダム化比較なら交絡・傾向スコア・感度分析
- 縦断研究なら time zero・追跡・脱落
- 予測モデルなら分割・検証・calibration・fairness

### Step 6. 変更管理ルールを書く
「変更しない」より、「変更したときにどう記録するか」を決める方が現実的です。

### Step 7. 主要結果を見る前に確定する
可能なら、
- データ固定前
- 盲検解除前
- 主要アウトカム集計前
- モデル選択前

の時点で version 1.0 を確定します。

---

## 8. よくある不備
これは非常によく見ます。

### 8-1. 「適切な方法で解析する」とだけ書く
これはSAPではありません。  
モデル名、対象集団、共変量、推定量まで書く必要があります。

### 8-2. 主要解析が複数ある
主解析が複数あると、結局どれが本命なのか分からなくなります。

### 8-3. 欠測の扱いが「欠測は除外する」
それだけでは不十分です。  
どの変数の欠測をどう扱うか、complete case が許容される根拠は何か、感度分析はするか、まで必要です。

### 8-4. サブグループ解析を思いついただけ全部入れる
サブグループ解析は、事前根拠が弱いと解釈が不安定です。  
主要サブグループだけに絞り、探索的と区別した方が安全です。

### 8-5. 因果研究なのに交絡調整の根拠がない
「年齢と性別で調整した」だけでは弱いです。  
なぜその変数群なのかを明示する必要があります。

### 8-6. 予測モデルなのに内部検証しかない
予測モデル研究では、開発しただけで終わると実用性判断が難しいです。  
少なくとも内部検証、望ましくは外部検証を考えます。

### 8-7. 変更履歴が残っていない
後で「最初からそう決めていたのか」が分からなくなります。

---

## 9. 汎用SAPテンプレート（コピペ用）
以下は、**研究デザイン横断で使える汎用テンプレート**です。  
不要項目は削除するより、まず `N/A` を入れてから整理する方が安全です。

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

## 3. Target quantity / estimand / prediction target
### 3.1 Primary target
- Population:
- Exposure / intervention / comparator:
- Outcome:
- Time horizon:
- Summary measure (e.g., mean difference, odds ratio, hazard ratio, C-statistic):
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
- Flow of participants / records:

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

## 5. Variable definitions
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
- Survey / longitudinal module attached? yes/no
- Prediction model module attached? yes/no

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

## 17. Outputs
- Planned primary tables:
- Planned primary figures:
- Supplementary materials:
- Reporting checklist(s) to use at manuscript stage:

## 18. References and appendices
- References:
- Appendices:
```

---

## 10. デザイン別テンプレート追加モジュール

## 10-1. RCT追加モジュール

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

## 10-2. 非ランダム化比較・因果推論追加モジュール

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

## 10-3. 調査・縦断・コホート追加モジュール

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

## 10-4. 予測モデル・機械学習追加モジュール

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

---

## 11. ガイドライン別に、SAPへどう落とし込むか

## 11-1. JAMA 2017 SAPガイドライン
### 強み
- SAPの**中身そのもの**を具体的に整理している
- 55項目という形で、抜け漏れ点検に使いやすい

### SAPで活かすポイント
- 文書管理
- 研究方法の明示
- 統計原則の明示
- 解析集団の明示
- 主解析、副次解析、欠測、感度分析の明示

### 注意
- 臨床試験文脈が前提
- 非臨床試験では「ランダム化」「有害事象」などは読み替えが必要

## 11-2. ICH E9 / E9(R1)
### 強み
- 「研究の問い」と「解析」をそろえる発想が強い
- E9(R1) は estimand と sensitivity analysis を明確化した

### SAPで活かすポイント
- 何を推定したいのかを先に書く
- 介入後事象や打ち切りの扱いを先に決める
- 主解析と感度分析の役割を分ける

### 臨床試験以外への一般化
- 介入研究でなくても、「目標となる数量」を明確にする
- 観察研究でも、因果質問・時間軸・比較戦略を明確にする
- 縦断研究でも、脱落や追跡終了をどう解釈するかを事前に書く

## 11-3. STROBE / RECORD
### 強み
- 観察研究の透明性を高める
- RECORD は routine data 利用時の追加論点が明確

### SAPで活かすポイント
- 対象者選定
- 変数定義
- 欠測
- バイアス
- データソースとリンク方法
- アルゴリズムやコードリストの明示

## 11-4. TREND / ROBINS-I / TARGET
### 強み
- 非ランダム化比較や因果推論で起きやすい問題に強い
- TARGET は target trial emulation を明示的に扱う

### SAPで活かすポイント
- 比較可能性確保の方法を事前規定する
- confounding と time zero をはっきり書く
- 未測定交絡や設計の脆弱性に対する感度分析を書く
- target trial のプロトコルそのものを明示する

## 11-5. TRIPOD+AI / PROBAST / PROBAST+AI
### 強み
- 予測モデル研究の設計・報告・批判的吟味に強い
- 特に analysis domain の不備を見つけやすい

### SAPで活かすポイント
- 開発と検証を分ける
- leakage を防ぐ
- calibration と fairness を明示する
- 過学習とサンプルサイズを意識する
- ハイパーパラメータ探索手順を固定する

## 11-6. AAPOR / SAMPL / preregistration
### AAPOR
調査研究で、サンプリング、調査モード、重み、品質管理の記載を補強できます。

### SAMPL
SAP専用ではありませんが、**統計記述の粒度**を上げる補助として便利です。

### preregistration
非臨床試験では、SAPを事前登録とセットで運用すると透明性が高まります。  
特に、公開済みデータや大規模既存データを使う研究では、**いつ何を固定したか**を示すのに有効です。

---

## 12. 研究デザインごとの最低限の書き分け早見メモ

### RCT
- 主解析集団
- ランダム化・盲検化
- adherance / protocol deviation
- estimand
- 中間解析と多重性

### 不等価統制群の比較試験
- 割付メカニズム
- 交絡因子
- バランス確認
- 主因果推定法
- 未測定交絡感度分析

### 観察研究・コホート・縦断
- time zero
- 追跡定義
- attrition
- survey weights / clustering
- 縦断モデル

### 因果推論
- 因果質問
- 比較戦略
- identification assumptions
- 主解析法
- 感度分析

### 予測モデル研究
- prediction target
- train/validation/test
- leakage prevention
- calibration/discrimination
- internal/external validation
- fairness

---

## 13. 実務上のおすすめ
最後に、かなり実務的なおすすめを書きます。

### 13-1. 「最終論文のMethods」ではなく「解析実行書」として書く
論文のMethodsより少し細かく、コードより少し抽象的、という位置づけがちょうどよいです。

### 13-2. 解析表（mock tables）を先に作る
どの表を出したいかを先に決めると、SAPの曖昧さがかなり減ります。

### 13-3. 主要解析は1本、感度分析は2〜4本くらいに絞る
多すぎると、逆に主張がぼやけます。

### 13-4. 予測研究では「性能がよかったら採用」ではなく、評価基準を先に書く
たとえば、
- calibration slope が一定範囲
- external validation で性能低下が一定範囲以内
- clinically acceptable threshold で感度・特異度が許容範囲
など、採用基準を先に書くとぶれにくいです。

### 13-5. 因果研究では DAG か交絡因子選定表を付ける
言葉だけより、かなり明確になります。

### 13-6. 調査研究では重みと非回答処理を軽視しない
とくに一般化可能性を主張する場合、ここを曖昧にすると弱いです。

---

## 14. 参考文献・主要ガイドライン
以下は、このガイドの作成時に土台として参照しやすい主要文献・ガイドラインです。

1. Gamble C, Krishan A, Stocken D, et al. **Guidelines for the Content of Statistical Analysis Plans in Clinical Trials.** JAMA. 2017;318(23):2337-2343.  
   - SAP内容そのものの最重要ガイドラインのひとつ
   - 55項目

2. International Conference on Harmonisation (ICH). **E9 Statistical Principles for Clinical Trials.** 1998.  
   - SAPをプロトコルより技術的・詳細な分析文書として位置づける基礎文書

3. ICH. **E9(R1) Addendum on Estimands and Sensitivity Analysis in Clinical Trials.** Step 5, effective 2020.  
   - estimand と sensitivity analysis を明確化

4. STROBE Statement. **Strengthening the Reporting of Observational Studies in Epidemiology.**  
   Website: https://www.strobe-statement.org/  
   - cohort / case-control / cross-sectional の基本報告指針

5. RECORD Statement. **REporting of studies Conducted using Observational Routinely-collected Data.**  
   Website: https://www.record-statement.org/  
   - routine data を使う観察研究の拡張

6. CDC. **TREND Statement (Transparent Reporting of Evaluations with Nonrandomized Designs).**  
   Website: https://www.cdc.gov/hivpartners/php/trend-statement/index.html  
   - 非ランダム化評価の報告指針
   - 22-item checklist

7. Matthews AA, Danaei G, Islam N, Kurth T. **Target trial emulation: applying principles of randomised trials to observational studies.** BMJ. 2022;378:e071108.  
   - 観察データで target trial を考える基本文献

8. Cashin AG, Hansford HJ, Hernán MA, et al. **Transparent reporting of observational studies emulating a target trial: the TARGET Statement.** BMJ. 2025;390:e087179.  
   - target trial emulation の報告ガイドライン
   - 21-item checklist

9. TRIPOD+AI. **TRIPOD+AI statement: updated guidance for reporting clinical prediction models that use regression or machine learning methods.** BMJ. 2024;385:e078378.  
   - prediction model 研究の新しい報告ガイドライン
   - 27-item checklist
   - TRIPOD-2015 を置換

10. Wolff RF, Moons KGM, Riley RD, et al. **PROBAST: A Tool to Assess the Risk of Bias and Applicability of Prediction Model Studies.** Ann Intern Med. 2019;170(1):51-58.  
    - 4 domains / 20 signaling questions

11. Moons KGM, Damen JAA, Kaul T, et al. **PROBAST+AI: an updated quality, risk of bias, and applicability assessment tool for prediction models using regression or artificial intelligence methods.** BMJ. 2025;388:e082505.  
    - regression とAIの両方に対応する更新版

12. AAPOR. **Disclosure Standards / Transparency Initiative.**  
    Website: https://aapor.org/standards-and-ethics/disclosure-standards/  
    - 調査研究の開示基準
    - サンプル、重み、モード、品質管理などの記載に有用

13. Lang T, Altman D. **SAMPL Guidelines** (Statistical Analyses and Methods in the Published Literature).  
    EQUATOR page: https://www.equator-network.org/reporting-guidelines/sampl/  
    - 統計報告の基本

14. Association for Psychological Science. **Preregistration of Research Plans.**  
    Website: https://www.psychologicalscience.org/publications/journals/psychological_science/preregistration  
    - 事前登録の考え方、逸脱の透明な報告

15. Open Science Framework (OSF).  
    Website: https://osf.io/about/  
    - 研究計画・登録・共有の実務基盤として利用可能

16. AEA RCT Registry. **Registration Guidelines / Data Elements Definitions.**  
    Documentation: https://docs.socialscienceregistry.org/  
    - 社会科学系の trial / pre-analysis plan 実務で参考になる

---

## 15. ひとことでまとめると
**良いSAPは、「あとで説明できる分析」ではなく、「先に説明してから実行する分析」を支える文書**です。  
臨床試験以外の領域では、単一の万能ガイドラインを探すより、

- **JAMA 2017 のSAP骨格**
- **ICH E9(R1) の問いと解析の整合**
- **STROBE / RECORD / TREND / TARGET / TRIPOD+AI などのデザイン固有指針**
- **ROBINS-I / PROBAST(+AI) などの“後で突っ込まれる点”の先回り**

を組み合わせる方が、ずっと実務的で強いです。

必要なら次の段階として、
- **あなたの研究デザイン別のSAPテンプレートをさらに具体化した版**
- **日本語の提出用ひな形**
- **査読対応を意識した短縮版SAP**
- **OSF登録用の簡略版**
のように展開できます。
