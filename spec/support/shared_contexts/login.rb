RSpec.shared_context "when logged in" do
  let!(:user) { User.create(name: "Scott") }
  before { get user_path(user.uuid) }
end

RSpec.shared_context "when logged out" do
  before { post logout_path }
end
