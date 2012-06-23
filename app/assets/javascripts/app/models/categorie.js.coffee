class App.Categorie extends Spine.Model
  @configure 'Categorie', 'slug', 'title', 'description', 'parent', 'post_count'
  @extend Spine.Model.Ajax