# 「FactoryBotを使用します」という記述
FactoryBot.define do
    # Nommez les données de テスト à créer "tâche"
    # 「task」のように存在するクラス名のスネークケースをテストデータ名とする場合、そのクラスのテストデータが作成されます
    factory :task do
      title { '書類作成' }
      content { '企画書を作成する。' }
    end
    # Nommez les données de テスト à créer "second_task"
    # 「second_task」のように存在しないクラス名のスネークケースをテストデータ名とする場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要があります
    factory :second_task, class: Task do
      title { 'メール送信' }
      content { '顧客へ営業のメールを送る。' }
    end
  end