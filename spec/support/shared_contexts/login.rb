RSpec.shared_context "when logged in" do
  let!(:current_user) { User.create(name: "Scott") }
  before { get user_path(current_user.uuid) }
end

RSpec.shared_context "when logged out" do
  before { post logout_path }
end
