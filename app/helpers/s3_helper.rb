require 'base64'
require 'openssl'
require 'digest/sha1'


module S3Helper

  def s3_policy
    policy_document = {
        expiration: '2014-04-01T00:00:00Z',
        conditions: [
            {bucket: 'mezerny'},
            ['starts-with', '$key', 'uploads/'],
            {acl: 'public-read'},
            {success_action_status: '201'},
        ]
    }
    Base64.encode64(policy_document.to_json).gsub("\n", '')
  end

  def s3_signature
    Base64.encode64(
        OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            'M2YCs38llYAkHu9xstfclqlWibya7iAnQKI1MBdJ', s3_policy)
    ).gsub("\n", '')
  end
end