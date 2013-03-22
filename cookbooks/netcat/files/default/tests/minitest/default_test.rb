describe_recipe "cookbook-netcat" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package(node['netcat']['package_name']).must_be_installed
    end
  end
end
