SkinnerPixlee.Views.InstaCollectionsShow = Backbone.View.extend({
  template: JST['insta_collections/show'],

  className: "row",

  events: {
    "click #previous-page-btn": "previousPage",
    "click #next-page-btn": "nextPage",
  },

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

  nextPage: function () {
    this.model.fetch({
      data: {offset: this.model.get("offset")}
    });
  },

  previousPage: function () {
    var offset = this.model.get("offset") - 40;
    offset = (offset > 0) ? offset : 0;
    this.model.fetch({
      data: {offset: offset}
    });
  },
});
