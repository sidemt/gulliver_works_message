# frozen_string_literal: true
# 職種
main_categories =
  [{ name: 'コンサル',
     sub_categories: [{ name: 'ビジネスコンサルタント', occupations: [{ name: '戦略・経営コンサルタント' },
                                                                      { name: '業務改革コンサルタント' },
                                                                      { name: '人事コンサルタント' },
                                                                      { name: '会計コンサルタント' },
                                                                      { name: '物流・SCMコンサルタント' },
                                                                      { name: 'リスクコンサルタント' },
                                                                      { name: 'マーケティングコンサルタント' },
                                                                      { name: '調査員・リサーチャー' },
                                                                      { name: 'その他ビジネスコンサルタント' }] },
                      { name: 'ITコンサルタント', occupations: [{ name: 'システムコンサルタント' },
                                                                { name: 'システムコンサルタント' }] }] },
   { name: 'SE・IT',
     sub_categories: [{ name: 'プログラマー・Webエンジニア', occupations: [{ name: 'アプリエンジニア' },
                                                                           { name: 'フロントエンドエンジニア' },
                                                                           { name: 'サーバーサイドエンジニア' }] },
                      { name: '社内SE', occupations: [{ name: '社内SE（アプリ）' },
                                                      { name: '社内SE（インフラ）' },
                                                      { name: 'IT戦略・システム企画' },
                                                      { name: '品質管理' },
                                                      { name: 'ヘルプデスク' }] },
                      { name: 'プロジェクト管理', occupations: [{ name: 'プロジェクトマネージャー' }] },
                      { name: 'Webサービス・制作', occupations: [{ name: 'Web企画・Webプロデューサー・Webディレクター' },
                                                                 { name: 'Web編集、コンテンツ企画' },
                                                                 { name: 'Webデザイナー・UI/UXデザイナー' },
                                                                 { name: 'ECサイト運営' }] },
                      { name: 'その他', occupations: [{ name: '組込み・制御エンジニア' },
                                                      { name: 'プリセールス・セールスエンジニア' },
                                                      { name: 'テクニカルサポート' },
                                                      { name: 'テスト・QAエンジニア' },
                                                      { name: 'システム監査' }] }] },
   { name: 'データサイエンス', sub_categories: [{ name: '全般', occupations: [{ name: 'ビジネス系' },
                                                                              { name: '研究系' },
                                                                              { name: '開発系' },
                                                                              { name: '機械学習全般' },
                                                                              { name: '音声' },
                                                                              { name: '自然言語' }] }] },
   { name: '企画/管理・マーケティング',
     sub_categories: [{ name: '企画', occupations: [{ name: '経営企画・事業企画' },
                                                    { name: '商品企画･サービス企画' },
                                                    { name: '営業企画' }] },
                      { name: '管理', occupations: [{ name: '未確定' }] },
                      { name: 'マーケティング', occupations: [{ name: '広告宣伝' },
                                                              { name: '販売促進・PR・SNS運用' },
                                                              { name: 'ブランド・プロダクトマネージャー' },
                                                              { name: 'CRM・ダイレクトマーケティング・カスタマーサクセス' },
                                                              { name: 'Web・デジタルマーケティング' },
                                                              { name: '市場調査・マーケティングリサーチ' },
                                                              { name: 'MD（マーチャンダイザー）' }] },
                      { name: '管理職・エグゼクティブ', occupations: [{ name: 'CEO、COO、CFO、CIO、CTO、経営幹部、幹部候補' },
                                                                      { name: '管理職（営業マネージャー・企画系）' },
                                                                      { name: '管理職（管理部門系）' },
                                                                      { name: '管理職（その他）' }] }] }]

main_categories.each do |main_category|
  OccupationMainCategory.find_or_create_by!(name: main_category[:name])
  main_category[:sub_categories].each do |sub_category|
    OccupationSubCategory.find_or_create_by!(name: sub_category[:name],
                                             occupation_main_category_id:
                                                 OccupationMainCategory.find_by(name: main_category[:name]).id)
    sub_category[:occupations].each do |occupation|
      Occupation.find_or_create_by!(name: occupation[:name],
                                    occupation_sub_category_id:
                                        OccupationSubCategory.find_by(name: sub_category[:name]).id)
    end
  end
end
