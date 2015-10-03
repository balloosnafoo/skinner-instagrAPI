SkinnerPixlee.Views.InstaCollectionsShow = Backbone.View.extend({
  template: JST['insta_collections/show'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    debugger;
    var renderedContent = this.template({
      instaCollection: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },
});
