class PostMailer < ApplicationMailer

  def post_created
    @user = params[:user]
    @post = params[:post]
    @greeting = "Hi"

    #attachments['logo1.png'] = File.read('app/assets/images/logo1.png')

    attachments["post_#{post.id}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'posts/show', layout: 'pdf', pdf: 'filename')
    )

    mail(

      to: User.first.email,
      subject: "new post created"
      #, cc: User.all.pluck(:email)
      #, bcc
    )

  end

  def new_post
    # post = Post.find(post_id)
    # @post = Post.first
    post = Post.first
    attachments["post_#{post.id}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'posts/show', layout: 'pdf', pdf: 'filename')
    )
    mail to: "to@example.org"
  end

end
