control 'bucket' do
  describe aws_s3_bucket(bucket_name: test_bucket_name) do
    it { should exist }
  end
  describe aws_s3_bucket_object(bucket_name: test_bucket_name, key: 'test1.txt') do
    it { should exist }
  end
  describe aws_s3_bucket_object(bucket_name: test_bucket_name, key: 'test2.txt') do
    it { should exist }
  end
end