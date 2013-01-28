required_packages = %w'libjpeg-devel libpng-devel libtiff-devel zlib-devel'

required_packages.each do |pkg|
  package pkg
end

tesseract_binary = "/usr/bin/tesseract"
tesseract_installed = ::File.exists?(tesseract_binary) && ::File.executable?(tesseract_binary)

remote_file "/tmp/leptonica-1.69.tar.gz" do
  not_if {tesseract_installed}
  source "http://www.leptonica.com/source/leptonica-1.69.tar.gz"
end

script "install leptonica" do
  not_if {tesseract_installed}

  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<CODE
tar zxvf leptonica-1.69.tar.gz
cd leptonica-1.69
./configure --prefix=/usr --libdir=/usr/lib64
make
make install
CODE
end

remote_file "/tmp/tesseract-ocr-3.02.02.tar.gz" do
  not_if {tesseract_installed}
  source "http://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz"
end

script "install tesseract" do
  not_if {tesseract_installed}

  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<CODE
tar zxvf tesseract-ocr-3.02.02.tar.gz
cd tesseract-ocr
./autogen.sh
./configure --prefix=/usr --libdir=/usr/lib64
make
make install
ldconfig
CODE
end