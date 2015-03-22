var displayGrowlMessage, growlTemplate, refreshView, root, triggerViewRefresh;

root = typeof exports !== "undefined" && exports !== null ? exports : this;

root.setAsyncNotifications = function() {
  var url;
  url = $('#notifications').data('url');
  return $.ajax({
    url: url,
    dataType: 'json'
  }).done(function(data) {
    return $.each(data, function(index, name) {
      return subscribeDanthesChannel(name);
    });
  });
};

root.subscribeDanthesChannel = function(name) {
  return Danthes.subscribe(name, function(data, channel) {
    if (data.event_type === 'notification') {
      return displayGrowlMessage(data);
    } else if (data.event_type === 'view_refresh') {
      return triggerViewRefresh(data);
    }
  });
};

displayGrowlMessage = function(data) {
  var growl_data, growl_options;
  growl_data = {
    title: data.title,
    message: data.message
  };
  growl_options = {
    type: data.type,
    delay: 3000,
    template: growlTemplate(),
    animate: {
      enter: 'animated fadeInRight',
      exit: 'animated fadeOutRight'
    }
  };
  return $.growl(growl_data, growl_options);
};

growlTemplate = function() {
  return '<div data-growl="container" class="[ col-xs-11 col-sm-3 ] alert" role="alert"><button type="button" class="close" data-growl="dismiss"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button><span data-growl="icon"></span><span data-growl="title"></span><span data-growl="message"></span><a href="#" data-growl="url"></a></div>';
};

triggerViewRefresh = function(data) {
  var context, current_action, current_app_id, current_controller, triggers;
  current_controller = $('body').data('controller');
  current_action = $('body').data('action');
  current_app_id = $('body').data('app-id');
  context = data['context'];
  triggers = data['triggers'];
  if (context.controller === current_controller && context.action === current_action && context.app_id === current_app_id) {
    return $.each(triggers, function(index, trigger) {
      return eval(trigger);
    });
  }
};

refreshView = function(url) {
  return $.ajax({
    url: url,
    dataType: 'script'
  });
};
