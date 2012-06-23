$ = jQuery.sub()
Categorie = App.Categorie

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Categorie.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('categories/new')

  back: ->
    @navigate '/categories'

  submit: (e) ->
    e.preventDefault()
    categorie = Categorie.fromForm(e.target).save()
    @navigate '/categories', categorie.id if categorie

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Categorie.find(id)
    @render()
    
  render: ->
    @html @view('categories/edit')(@item)

  back: ->
    @navigate '/categories'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/categories'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Categorie.find(id)
    @render()

  render: ->
    @html @view('categories/show')(@item)

  edit: ->
    @navigate '/categories', @item.id, 'edit'

  back: ->
    @navigate '/categories'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Categorie.bind 'refresh change', @render
    Categorie.fetch()
    
  render: =>
    categories = Categorie.all()
    @html @view('categories/index')(categories: categories)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/categories', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/categories', item.id
    
  new: ->
    @navigate '/categories/new'
    
class App.Categories extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/categories/new':      'new'
    '/categories/:id/edit': 'edit'
    '/categories/:id':      'show'
    '/categories':          'index'
    
  default: 'index'
  className: 'stack categories'