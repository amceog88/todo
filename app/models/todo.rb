class Todo < ApplicationRecord
  validates_presence_of :name, :due_date, :note

  validates :name, length: { maximum: 20 }

  # 判斷是否能夠刪除
  # 判斷條件可能有很多，所以將各項判斷分拆到 private method
  def can_destroy?
    # 沒過期的話，回傳 true = 可刪除
    !overdue?
  end

  # 宣告以下為 private method
  # private_method 無法被直接使用
  # `todo.overdue?` 會跳出錯誤: NoMethodError: private method `overdue?`'
  # 可以用 Ruby 原生的 Kernel#send 來呼叫 private_method: todo.send(:overdue?)
  private

  # 如果 due_date 比今天小，則回傳 true = 過期
  def overdue?
    due_date < Date.today
  end
end