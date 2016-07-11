packages = ['httpd','vim','nano']

packages.each do |p|
  yum_package p do
    action :install
  end
end

service "httpd" do
  action :start
end
