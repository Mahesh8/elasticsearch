require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)
  end

  test "should get index" do
    get documents_url
    assert_response :success
  end

  test "should get new" do
    get new_document_url
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post documents_url, params: { document: { automated: @document.automated, deafult_price: @document.deafult_price, description: @document.description, name: @document.name, priorty: @document.priorty, service_id: @document.service_id, stamp_required: @document.stamp_required, status_id: @document.status_id, tat: @document.tat, template_url: @document.template_url, user_id: @document.user_id } }
    end

    assert_redirected_to document_url(Document.last)
  end

  test "should show document" do
    get document_url(@document)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_url(@document)
    assert_response :success
  end

  test "should update document" do
    patch document_url(@document), params: { document: { automated: @document.automated, deafult_price: @document.deafult_price, description: @document.description, name: @document.name, priorty: @document.priorty, service_id: @document.service_id, stamp_required: @document.stamp_required, status_id: @document.status_id, tat: @document.tat, template_url: @document.template_url, user_id: @document.user_id } }
    assert_redirected_to document_url(@document)
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end
