class CharRecognitionsController < ApplicationController
  def index
    hash = nil
    File.open(ENV['GOOGLE_CLOUD_KEYFILE']) do |j|
      hash = JSON.load(j)
    end
    image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new(
      version: :v1,
      credentials: hash
    )

    local_image_path = './receipt.png'
    image_content = File.open(local_image_path, 'r')
    image = { content: image_content }

    type = :TEXT_DETECTION
    features_element = { type: type }
    features = [features_element]

    requests_element = { image: image, features: features }
    requests = [requests_element]

    @response = image_annotator_client.batch_annotate_images(requests).responses[0]
  end
end
