# OSF Preregistration Preparation Template

このファイルは、OSF の preregistration 登録前に回答案を整理するための下書きテンプレートです。
OSF の画面構成に沿って並べているので、必要事項を埋めたうえで登録画面へ転記してください。
各項目には「何を書くべきか」の説明を残してあります。任意項目は不要なら空欄のままで構いません。
複数項目がありうる欄では、下の記入欄は例示です。個数の上限を示すものではないので、研究内容に応じて行やブロックを必要な数だけ追加して使ってください。

## 記入・転記時の体裁メモ

このテンプレート内の `##` や `###` などの見出しは、編集時の区切りとして Markdown 記法のまま維持して構いません。
一方で、OSF の各入力欄へ実際にコピペする回答本文では、公開Review画面で記号がそのまま表示されることがあるため、Markdown 表、コードフェンス、太字記号、不要なバッククォートは使わず、通常の文章やコロン区切りの行で書くことを推奨します。
たとえば、表は `項目: 内容` の行に直し、ルーブリックは `1 point: ...` のような通常テキストとして貼り付けます。

---

## 1. Registration Metadata

このメタデータは作成中の registration にだけ適用され、関連 project には適用されない。

### Title
研究の主題がすぐ分かる、簡潔で具体的なタイトルを書く。研究の中心となる問いや対象、方法が伝わる表現にする。OSF 上では必須項目。

- 登録タイトル:

### Description
研究プロジェクトの概要を説明する欄。研究の目的、背景、何を明らかにしたいか、どのような成果が見込まれるかを、第三者が読んで全体像を把握できる程度に書く。

- 研究概要:
- 背景:
- 目的:
- 期待される成果:

### Contributors
登録に含める研究協力者を書き出す。OSF 上での権限、書誌情報への掲載有無、必要に応じて所属履歴や学歴情報も整理しておく。

- 必要人数分だけ以下のブロックを複製して記入する。

#### Contributor
- Name:
- Permissions:
- Bibliographic Contributor: Yes / No
- Employment history:
- Education history:

### Affiliated Institutions
OSF の affiliated institutions サービスによって registration に自動適用される所属機関を確認する。所属機関が OSF の対象機関か不明な場合は、OSF 上の一覧で確認する。該当機関がなければ空欄または該当なしとして扱う。

- 必要な数だけ列挙する。
- 所属機関:
- ROR など識別情報があれば:
...

### License
registration として提出する情報やファイルにどのライセンスを適用するかを決める欄。関連 project 全体ではなく、registration として提出される内容に適用される。将来の再利用条件に関わるため、研究チームの方針に合うものを選ぶ。

- 選択するライセンス:
- 選択理由メモ:
- チーム内での合意状況:

### Subjects
研究が属する主題領域を整理する。検索性や分類に影響するため、広すぎず狭すぎない主題を選ぶ。

- 必要な数だけ列挙する。
- Subject:
...

### Tags (Optional)
研究内容を表す具体的なキーワードを列挙する。手法、対象、主要概念、データ種別など、検索で見つけてもらうための語を優先する。

- 必要な数だけ列挙する。
- Tag:
...

---

## 2. Overview

### Research questions or hypotheses
この研究で検証する研究課題または仮説を書く。各項目は分けて、できるだけ具体的かつ検証可能な形にする。結果が得られたときに、その結果がどの問いや仮説を支持・反証するのかが直接分かる書き方にする。

- 研究課題や仮説ごとに、必要な数だけ列挙する。
- RQ / H:
...

### Foreknowledge of data or evidence
事前登録では、データを見る前に決めた分析と、データを見た後に決めた分析を区別することが重要になる。既存データを用いる場合は、著者がどの程度そのデータを把握しているかが分析計画に影響しうるため、最も近い状態を 1 つ選ぶ。

- [ ] Data does not yet exist: この分析計画で使うデータはまだ存在せず、登録完了後までデータの生成や収集は行われない。
- [ ] Data exists but the authors cannot observe it yet: この分析計画で使うデータの少なくとも一部は存在するが、著者は登録完了後までアクセスできない。
- [ ] Data exists but the authors have not observed it yet: データの少なくとも一部は存在し、著者はアクセス可能だが、著者はまだデータを見ておらず、登録完了後まで見ない。
- [ ] Only people other than the authors have observed the data: 著者以外の人はデータを見ているが、著者自身はまだ見ておらず、登録完了後まで見ない。
- [ ] Authors' limited observation of the data could not influence their analysis decisions: 著者はデータの少なくとも一部を見ているが、この分析計画に関する分析判断へ影響しうる証拠を十分には見ていない。
- [ ] Authors have observed the data, but have not performed the proposed analyses: 著者はデータを見ており、分析判断や結論に影響しうる証拠を把握しているが、この計画で提案する分析はまだ実施していない。
- [ ] Authors have observed the data: 著者はデータを見ており、上記のより厳しい条件を満たすとは表明できない。
- [ ] Analyses in this plan have been conducted already: この分析計画に含まれる分析の少なくとも一部はすでに実施済みであり、retrospective registration にあたる。

### Explanation of foreknowledge and managing unintended influences (Optional)
既存データを使う場合は、どの程度の事前知識があるか、分析計画や結論への意図しない影響を減らすためにどのような対策を取ったかを補足する。事前知識の量にかかわらず、分析計画がデータに依存して決まったように見えるリスクを減らす手順があれば明記する。

- 既存データとの関係:
- 著者がどこまで把握しているか:
- 意図しない影響を減らすための対策:

---

## 3. Research Design

### Study type
研究デザインとして最も近いものを選ぶ。分析の目的や因果推論の意図に応じて、OSF 上で最も適切な分類に合わせる。

- [ ] Randomized Experiment: 対象を条件や treatment にランダム割り付けする実験。実験室実験、フィールド実験、介入実験、RCT、A/B テストなどを含む。
- [ ] Non-randomized study: 対象を条件や treatment にランダム割り付けしない研究。相関研究、観察研究、調査、自然実験、real-world evidence study、regression discontinuity design、記述研究などを含む。
- [ ] Systematic review: 既存研究を体系的に集めてまとめる研究。メタアナリシスや scoping review を含む。
- [ ] Adjustment or control-based design: 他の要因を統計的に調整・統制して主要な関係を推定するデザイン。通常は、影響を取り除いて因果効果をより分離する目的で用いる。
- [ ] Quasi-experimental design: 因果関係を同定または推定するために、調整変数への依存を減らせる特徴や状況を利用するデザイン。instrumental variables、自然実験、interrupted time series、difference-in-differences、synthetic controls などを含む。
- [ ] Descriptive study: 因果推論よりも、データや標本の特徴記述を主目的とする研究。
- [ ] Simulation study: 既存データや合成データを用いて、モデルの性能、既存または提案システムの挙動、政策効果、集団内の行動やアウトカムなどを模擬・予測する研究。
- [ ] Other: 上記に当てはまらない場合。

- 補足説明:

### Intention for causal interpretation (Optional)
主要変数間の関係について、因果的な解釈をどの程度意図しているかを書く。研究目的と設計の整合が取れているように記述する。

- [ ] No causal relationship inferred: 因果関係を推論することは目的ではない。
- [ ] Indirect inference on causal relationship(s): 因果関係に関心はあるが、その因果効果を直接同定する設計ではない。
- [ ] Direct inference on causal relationship(s): 因果効果の推定や因果推論そのものを目的とし、そのための設計になっている。

- 補足説明:

### Blinding of experimental treatments
実験を study type として選んだ場合は、実験 treatment、操作、条件を誰が把握しているかについて、該当するものをすべて選ぶ。

- [ ] No blinding is involved: ブラインド化は行わない。
- [ ] Subjects will not be aware of the assigned treatment during data collection: 対象者はデータ収集中に割り当てられた treatment を知らない。人間参加者でない場合やブラインド化手順による場合を含む。
- [ ] Researchers who interact with the subjects will not be aware of the assigned treatments during data collection: 対象者に接する研究者は、データ収集中に割り当てられた treatment を知らない。
- [ ] Researchers or observers who code or interpret data for analysis will not be aware of the assigned treatments during coding: 分析用データをコーディングまたは解釈する研究者・観察者は、コーディング中に割り当てられた treatment を知らない。

### Additional blinding during research or analysis (Optional)
研究の種類にかかわらず、対象者、研究者、コーダー、解析者が研究デザイン、treatment、測定、アウトカムを知ることで生じうる意図しない影響を減らすための手順があれば書く。

- ブラインド化の追加手順:
- 解析者・評価者への情報制限:

### Study design
条件や treatment がどのように実施され、測定やアウトカムがどのように評価されるかを、第三者が理解できる程度に具体的に記述する。群数、要因計画、randomized block、反復測定、between-subject / within-subject / mixed の別、counterbalancing、条件提示順、測定タイミングなどを明示する。

- デザインの概要:
- 条件 / 群 / treatment arms:
- between-subject / within-subject / mixed の別:
- 測定タイミング:
- counterbalancing の有無と方法:
- 実施手順の要約:

### Randomization (Optional)
ランダム化研究であれば、どの単位をどの手法でランダム化するかを書く。単に乱数の出所を書くのではなく、simple randomization、block randomization、stratified randomization などの方式を特定する。

- ランダム化の有無:
- ランダム化単位:
- ランダム化手法:
- 実装手順:

---

## 4. Sampling

### Data collection procedures
どのようにサンプリング戦略を定義し、新規データを収集するか、または既存データを取得・準備するかを書く。対象母集団、サンプリングフレーム、募集方法、組み入れ・除外基準、データ源や場所、地域、試薬などのバッチ番号、既存データの取得と前処理、収集期間などを含める。

- 対象集団:
- サンプリングフレーム:
- 募集方法:
- 組み入れ基準:
- 除外基準:
- データ源 / 取得場所:
- 収集期間の見込み:
- 既存データを使う場合の取得・整形手順:

### Sample size
分析単位ごとのサンプルサイズを書く。群間で同数かどうか、クラスターや階層構造がある場合は各レベルで何件・何人・何単位を予定しているかも明示する。

- 分析レベルや群ごとに、必要な数だけ追記する。
- 分析単位 / レベル:
- 予定サンプルサイズ:
- 群や条件との対応:
- 備考:
...

### Sample size rationale (Optional)
予定サンプルサイズの根拠を書く。パワー分析、時間や予算などの制約、Bayesian または responsive design の事前定義済み判断規則など、どの判断にもとづくかを説明する。

- 根拠:
- パワー分析をした場合の前提:
- 実務上の制約がある場合の説明:

### Starting and stopping rules
新規データ収集や既存データの一部利用では、いつ pilot を終えて本収集に入るか、いつデータ収集を終了するか、中止判断をどう行うかを事前に書く。

- pilot と本収集の切り分け:
- 収集開始条件:
- 収集終了条件:
- 中止基準:

---

## 5. Variables

### Manipulated variables
操作する変数がある場合、その変数名、水準、treatment arms、実際にどう操作するかを書く。ランダム化を伴わない研究で操作変数がない場合は、none と明記する。

- 操作変数ごとに、必要な数だけ以下を複製して記入する。
- 変数名:
- 水準 / treatment arms:
- 操作方法:
...

### Measured variables
測定されるすべての変数を書く。アウトカム、観察研究の predictors、共変量、除外判定やサブセット化に使う変数、測定方法やデータソースも含める。

- 変数ごとに、必要な数だけ以下を複製して記入する。
- 変数名:
- 役割: primary outcome / secondary outcome / predictor / covariate / exclusion / subset
- 測定方法:
- データ型 / 単位:
...

### Indices
測定変数を組み合わせて作る index や派生変数がある場合、その作成方法を具体的に書く。平均、合計、標準化、重みづけ、スコアリング規則、数式などを明示する。

- 指標や派生変数ごとに、必要な数だけ以下を複製して記入する。
- 合成指標 / 派生変数の名称:
- 作成ルール:
- 計算式:
- 標準化 / 平均化 / 加重の有無:
...

---

## 6. Analysis Plan

### Statistical models
各研究課題や仮説に対して、どの統計モデルで検証するかを具体的に書く。ANOVA、回帰、SEM、混合効果モデルなどのモデル種別だけでなく、モデル仕様、含める変数、交互作用、サブグループ解析、pairwise または complex contrasts、omnibus test 後の follow-up tests、positive controls、negative controls、manipulation checks、収束基準、モデル前提の検定まで明記する。controls、checks、収束、前提検定の結果によってモデルを使うかどうかが変わる場合は、その判断基準も書く。第三者が同じ分析を再現できる粒度を目指す。

- 研究課題 / 仮説ごと、または解析モデルごとに、必要な数だけ以下を複製して記入する。
- 対象となる研究課題 / 仮説:
- モデル名 / モデル種別:
- 従属変数:
- 独立変数:
- 交互作用:
- 共変量:
- サブグループ解析:
- 事後比較:
- contrasts / follow-up tests:
- positive / negative controls:
- manipulation checks:
- 収束基準:
- 前提検定:
- モデル採用条件や判断基準:
...

### Transformations
カテゴリ変数のコーディング方法、中心化、標準化、対数変換、再符号化など、分析前に行うデータ変換を書く。変換しない場合はその旨を明記する。

- カテゴリ変数のコーディング:
- 変換・中心化・再符号化:
- 実施しない場合はその旨:

### Inference criteria
何をもって結果を解釈するかを書く。p 値、信頼区間、Bayes factor、特定のモデル適合度指標、閾値、片側 / 両側検定、多重条件比較や複数仮説検定への対応などを明示する。

- 主要な判断基準:
- 有意水準または閾値:
- 片側 / 両側検定:
- 多重比較への対応:
- Bayesian 指標や適合度指標を使う場合の基準:

### Data inclusion and exclusion
どのデータ・対象を解析に含め、どの条件で除外するかを書く。外れ値処理、品質管理、プロトコル逸脱、事前定義した除外条件があれば具体的に示す。

- 解析対象に含める基準:
- 除外基準:
- 外れ値の扱い:
- 品質管理による除外ルール:

### Missing data
欠測をどう扱うかを書く。complete-case analysis、単純代入、多重代入、モデルベース処理など、採用する方針と条件を明示する。利用可能な全データでモデルを実行し、それ以外には欠測を考慮しない場合もその旨を書く。

- 欠測の定義:
- 欠測への対処法:
- complete-case / imputation などの方針:

### Other planned analysis (Optional)
上記の主要解析より中心性が低い、追加の予定解析があれば書く。副次的解析、探索的解析、感度分析などを、主要解析と区別がつくように整理する。

- 必要な数だけ列挙する。
- 解析の種類: secondary / exploratory / sensitivity
- 内容:
- 実施条件や位置づけ:
...

---

## 7. Other

### Context and additional information (Optional)
前の欄では書ききれないが、研究の理解に役立つ補足を書く。研究の文脈、実施上の制約、倫理面の補足、データ共有や再現性の方針、解釈上の注意点などをここにまとめる。

- 研究の文脈:
- 実施上の制約:
- 倫理・データ共有・再現性に関する補足:
- その他メモ:

---

## 8. Final Check

- [ ] 研究課題 / 仮説と分析計画の対応が明確
- [ ] 主要アウトカムと主要解析が明示されている
- [ ] サンプルサイズと根拠が記載されている
- [ ] 除外基準と欠測対応が記載されている
- [ ] 事前に決めた事項と探索的事項が区別されている
- [ ] OSF 上の選択式項目に対応する選択肢を埋めた
- [ ] OSF に貼る回答本文から、不要な Markdown 表記を除去した
