require "slack-notify"
require 'clockwork'
require 'dotenv'
# 下記のgemをrequireすると、minutesなどの時間を指し示すメソッドを使えるようになるので、記述しておくことを推奨します。
require 'active_support/time'
include Clockwork

Dotenv.load('./.env')

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
end
  # ここに、「どれくらいの周期で処理をするのか？」というClockworkのメソッドを記述します
  # ここに、slackで一定時間ごとに送りたい処理と設定を書き込みます

  every(3.minutes, 'job') do
    client = SlackNotify::Client.new(
      webhook_url: ENV["WEBHOOK_URL"],
      channel: "#general",
      username: "testbot",
      icon_url: "http://mydomain.com/myimage.png",
      icon_emoji: ":shipit:",
      link_names: 1
      )
    client.notify("課題用テストメッセージです")
  end