require 'rails_helper'

describe TrackReceiver, :vcr => true do
  it "returns a 200 success header when the API call is made" do
    response = TrackReceiver.get_tracks_restclient
    expect(response.code).to(eq(200))
  end

  it "returns tracks when the API call is made" do
    response = JSON.parse(TrackReceiver.get_tracks_restclient)

    expect(response["results"]).to_not(eq(nil))
  end
end