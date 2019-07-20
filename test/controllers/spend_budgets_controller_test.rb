require 'test_helper'

class SpendBudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spend_budget = spend_budgets(:one)
    @user = users(:one)
    @spend_reason = spend_reasons(:one)
  end

  test "should get index" do
    get spend_budgets_index_path(:year => 2019, :month => 07)
    assert_response :success
  end

  test "should get new" do
    get new_spend_budget_path
    assert_response :success
  end

  test "should create spend_budget" do
    assert_difference('SpendBudget.count') do
      post spend_budgets_path, params: { spend_budget: { target_date: Date.new(2019, 07, 10), amount: 3000, spend_reason_id: @spend_reason.id, user_id: @user.id, memo: ' ' } }
    end

    assert_redirected_to spend_budgets_index_url(:year => (@spend_budget[:target_date]).year, :month => (@spend_budget[:target_date]).month)
  end

  test "should get edit" do
    get edit_spend_budget_path(@spend_budget)
    assert_response :success
  end

  test "should update spend_budget" do
    patch spend_budget_path(@spend_budget), params: { spend_budget: { target_date: Date.new(2019, 07, 10), amount: 3500, spend_reason_id: @spend_reason.id, user_id: @user.id, memo: '' } }
    assert_redirected_to spend_budgets_index_url(:year => (@spend_budget[:target_date]).year, :month => (@spend_budget[:target_date]).month)
  end

  test "should destroy spend_budget" do
    assert_difference('SpendBudget.count', -1) do
      delete spend_budget_path(@spend_budget)
    end

    assert_redirected_to spend_budgets_url
  end
end
