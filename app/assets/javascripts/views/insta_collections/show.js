SkinnerPixlee.Views.InstaCollectionsShow = Backbone.View.extend({
  template: JST['insta_collections/show'],

  className: "row",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      instaCollection: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },
});
