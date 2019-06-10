require 'test_helper'

class SpendBudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spend_budget = spend_budgets(:one)
  end

  test "should get index" do
    get spend_budgets_url
    assert_response :success
  end

  test "should get new" do
    get new_spend_budget_url
    assert_response :success
  end

  test "should create spend_budget" do
    assert_difference('SpendBudget.count') do
      post spend_budgets_url, params: { spend_budget: {  } }
    end

    assert_redirected_to spend_budget_url(SpendBudget.last)
  end

  test "should show spend_budget" do
    get spend_budget_url(@spend_budget)
    assert_response :success
  end

  test "should get edit" do
    get edit_spend_budget_url(@spend_budget)
    assert_response :success
  end

  test "should update spend_budget" do
    patch spend_budget_url(@spend_budget), params: { spend_budget: {  } }
    assert_redirected_to spend_budget_url(@spend_budget)
  end

  test "should destroy spend_budget" do
    assert_difference('SpendBudget.count', -1) do
      delete spend_budget_url(@spend_budget)
    end

    assert_redirected_to spend_budgets_url
  end
end
