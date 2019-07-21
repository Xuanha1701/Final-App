## Review 1st 20190721 - Revision fd18c4

1. Ko commit những file ko dùng đến

    - app/assets/*
    - app/helpers/*

2. App ko có cơ chế authorization phù hợp

    - app/controllers/comments_controller.rb: một user dù có hay không đăng nhập cũng đang dễ dàng tạo và xoá 1 comment của 1 post!
    - app/controllers/posts_controller.rb: khi create mà để user submit parans `user_id` lên server và dùng cái đó tạo post thì thằng Nguyễn Văn A nó tạo post dưới tên thằng Nguyễn Văn B thì làm sao mà chặn!!!
    - app/controllers/users_controller.rb: khi edit mà dùng `params[:id]` để tìm kiếm thì 1 thằng user bất kỳ nó cứ pass cái ID bậy bậy lên là nó có thể dò ra profile của thằng user khác thì sao!!!

3. App tốt là khi có action gì đó thành công cần có (flash) message thông báo cho user

    -  app/controllers/follows_controller.rb: follow và unfollow thành công ko thấy message gì hết

4. Tận dụng những gì rails và gems cung cấp sẵn, ko nên tự làm lại cái người khác đã hỗ trợ mình

    - app/controllers/home_controller.rb: user cần login thì mới access vào index dc sao ko dùng `authenticate_user!` của `devise` mà đi `if/else` làm gì.

5. Coding style gớm quá

    - app/controllers/likes_controller.rb: indent lung tung, ko biết dùng blank line để code dễ nhìn, break line lung tung.
    - app/controllers/users_controller.rb
    - app/controllers/posts_controller.rb

6. Ko tận dụng được sức mạnh của ActiveRecord: association

    -  app/controllers/likes_controller.rb#already_liked?: `Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?` => `current_user.likes.exists?(post_id: params[:post_id])`

7. Code dư thừa:

    - app/controllers/relationships_controller.rb: Ko thấy dùng ajax ở javascript sao trên controller có xử lý để trả về format `js` nữa? Có thật có chỗ dùng format này ko? Controller chỉ còn xử lý để trả về response cho format nào mà dưới client có dùng thôi, ko phải lúc nào cũng cần `respond_to` rồi trả nhiều format về.
    - app/models/follow.rb: validate rule giống nhau thì group vào 1 dòng, chia nhiều dòng làm gì

    ```
    validates :follower_id, presence: true
    validates :following_id, presence: true
    ```

    => `validates :follower_id, :follower_id, presence: true`

8. Viết template thì format HTML nên sử dụng SLIM, format `js` nên sử dụng `erb`