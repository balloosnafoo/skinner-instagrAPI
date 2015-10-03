window.SkinnerPixlee = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new SkinnerPixlee.Routers.Router({
      $rootEl: $('#content'),
      instaCollections: new SkinnerPixlee.Collections.InstaCollections()
    });

    Backbone.history.start();
  }
};
