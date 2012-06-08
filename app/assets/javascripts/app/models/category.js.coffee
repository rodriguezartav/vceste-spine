class App.Category extends Spine.Model
  @configure 'Category', 'slug', 'title', 'description', 'parent', 'post_count'
  @extend Spine.Model.Ajax