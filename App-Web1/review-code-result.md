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

----

## Review 2nd 20190725 - Revision 70e3a5

1. Các chức năng js của những page khác nhau nên có những file khác nhau handle để dễ manage. Chức năng nào chung giữa các page thì đem vào 1 file dùng chung, `common.coffee` chẳng hạn. Cái gì cũng quăng hết vào `App-Web1/app/assets/javascripts/application.js` thì sao quản lý. App cần dùng nhiều js mà dùng 1 file như thế nào nó lên tỷ dòng sao mà đọc.

2. Code dư thừa

    - Sinh ra 1 nùi Admin controllers và cho kế thừa Devise controllers có được gì đâu!
    - App-Web1/app/controllers/albums_controller.rb: chỗ `update/destroy` thấy chỉ handle mỗi format `html` thì dùng `respond_to` làm gì. Chỉ dùng `respond_to` nếu `action` cần handle nhiều format khác nhau.


3. App ko có cơ chế authorization phù hợp

    - App-Web1/app/controllers/albums_controller.rb: khi create mà để user submit parans `user_id` lên server và dùng cái đó tạo post thì thằng Nguyễn Văn A nó tạo post dưới tên thằng Nguyễn Văn B thì làm sao mà chặn!!!
    - App-Web1/app/controllers/comments_controller.rb: khi delete 1 comment chỉ find = `id` sau đó delete luôn mà ko check quyền gì cả thì thằng user A nó sẽ dễ dàng delete được comment của user B mà ko cần biết nó có quyền làm điều đó hay ko.
    - App-Web1/db/migrate/20190724021744_change_post_id_to_photo_id.rb: method `rename_column` là 1 revertable method, ko cần define method `up/down`, dùng `change` là đủ.


4. Code không hiểu được!

    - App-Web1/app/controllers/albums_controller.rb: khi `edit`, `destroy`, `update` thì `@album` ở đâu ra xài hay vây?
    - App-Web1/app/controllers/likes_controller.rb#create: call `@like.save` 2 lần để làm gì?. Còn vấn đề nữa là method này có works đuco75 ko vậy, thấy đang call 1 method khác mà method đó bị comment rồi @.@ (params_data_photo)
    - App-Web1/app/controllers/relationships_controller.rb#follow_user: sai syntax, dư dấu `}`?

5. Không tận dụng được sức mạnh của ActiveRecord: association

    - App-Web1/app/controllers/photos_controller.rb#likes

    `if Like.where(photo_id: params[:photo_id], user_id: current_user.id).empty?` => `if current_user.likes.exists?(photo_id: params[:photo_id])`

    `@like = Like.new(photo_id: params[:photo_id], user_id: current_user.id)` => `@like = current_user.likes.build(photo_id: params[:photo_id])`

6. Không được dùng biến instance (@) trong partial

7. Code viết khá loạn, comment tùm lum tùm la!