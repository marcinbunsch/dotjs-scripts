unless window.location.pathname.match('achievements')
  $ ->
    outerHTML = (node) ->
      # stolen from http://stackoverflow.com/questions/1700870/how-do-i-do-outerhtml-in-firefox
      node.outerHTML || new XMLSerializer().serializeToString(node)

    iframe = $('<iframe src="/achievements" id="achievments_iframe" />')
    $('body').append iframe
    iframe.hide().load ->
      window.$('#achievments_iframe').get(0).contentWindow.$('.badge').each (index, badge) ->
        image = $(badge).find('.image img')
        # grab the title from the paragraph
        title = $(badge).find('> p').html()
        # If a badge is present, do nothing
        return if $('#medals img[alt="'+image.attr('alt')+'"]').length > 0
        # Make the missing badges semi-transparent, they look sexy this way
        img = $(outerHTML(image.get(0)))
        img.attr('title', title).addClass('tip').css({opacity:0.5})
        $('#medals').append(img)
      $(".tip").tipTip({maxWidth: "auto", edgeOffset: 10})
