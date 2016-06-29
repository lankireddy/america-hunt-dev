<% module_namespacing do -%>
describe <%= class_name %>Controller do

<% for action in actions -%>
  describe "GET #<%= action %>" do
    it "returns http success" do
      get :<%= action %>
      expect(response).to have_http_status(:success)
    end
  end
<% end -%>
end
<% end -%>
