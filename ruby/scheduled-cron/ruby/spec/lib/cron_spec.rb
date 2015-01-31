require "spec_helper"
require "cron"

describe Cron do
  let(:current_hour)   { 16 }
  let(:current_minute) { 10 }
  let(:config)   { read_file(expand_path("../../support/config")) }
  subject(:cron) {
    Cron.new(
      :current_hour   => current_hour,
      :current_minute => current_minute,
      :config => config,
    )
  }

  it "cron" do
    expect(STDOUT).to receive(:print).with(
"15:30 tomorrow - /bin/run_me_daily
16:45 today - /bin/run_me_hourly
16:10 today - /bin/run_me_every_minute
19:00 today - /bin/run_me_sixty_times"
    )

    cron.call
  end

  private

  def read_file(path)
    File.read(path)
  end

  def expand_path(path)
    File.expand_path(path, __FILE__)
  end
end
