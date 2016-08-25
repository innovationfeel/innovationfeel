module HomeHelper

  def earth_globe_link
    content_tag :span, class: 'earth-globe-container' do
      html = link_to(
        content_tag(:span, nil, class: 'glyphicon earth-globe'),
        '#', class: 'icon', rel: 'popover', tabindex: '0',
        data: {
          toggle: 'popover',
          turbolinks: false
        }
      )
      html += content_tag :div, class: 'hide earth-globe-popover-content' do
        content_tag :ul do
          concat content_tag(:li, link_to(t('language.english'), '#', class: 'active'))
          concat content_tag(:li, link_to(t('language.spanish'), '#'))
          concat content_tag(:li, link_to(t('language.german'), '#'))
          concat content_tag(:li, link_to(t('language.russian'), '#'))
        end
      end
    end
  end
end
