class ShareMailer < ApplicationMailer
  def share_mail(post)
    @post = post
    area = Area.find(@post.area_id)
    @users = area.selecting_users
    @users.each do |user|
      begin
        mail to: user.email, subject: "あなたの登録地域で危険情報が投稿されました"
      rescue => e
        logger.error e
      end 
    end
  end
end
