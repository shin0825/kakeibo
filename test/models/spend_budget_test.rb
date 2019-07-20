require 'test_helper'

class SpendBudgetTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @spend_reason = spend_reasons(:one)
    @spend_budget = SpendBudget.new(
        target_date: Date.new(2019, 07, 19), amount: 1, spend_reason_id: @spend_reason.id, user_id: @user.id, memo: 'a' * 50
      )
  end

  test "should be valid" do
    assert @spend_budget.valid?
  end

  test "amount should be present" do
    @spend_budget.amount = nil
    assert_not @spend_budget.valid?
  end

  test "amount should be numeric" do
    @spend_budget.amount = 'a'
    assert_not @spend_budget.valid?
  end

  test "amount should not be negative number" do
    @spend_budget.amount = -1
    assert_not @spend_budget.valid?
  end

  test "amount should not be decimal" do
    @spend_budget.amount = 0.5
    assert_not @spend_budget.valid?
  end

  test "amount should be zero" do
    @spend_budget.amount = 0
    assert @spend_budget.valid?
  end

  test "amount should be maxium" do
    @spend_budget.amount = 1000000000 - 1
    assert @spend_budget.valid?
  end

  test "amount should not be too much" do
    @spend_budget.amount = 1000000000
    assert_not @spend_budget.valid?
  end

  test "memo should not be too long" do
    @spend_budget.memo = "a" * 51
    assert_not @spend_budget.valid?
  end
end
