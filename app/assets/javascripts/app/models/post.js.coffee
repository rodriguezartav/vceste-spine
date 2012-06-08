class App.Post extends Spine.Model
  @configure 'Post', 'type', 'slug', 'url', 'status', 'title', 'title_plain', 'content', 'excerpt', 'date', 'modified', 'categories'
  @extend Spine.Model.Ajax