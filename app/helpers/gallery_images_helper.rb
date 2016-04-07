module GalleryImagesHelper
  def facet_link(subject)
    link_to subject.capitalize, add_to_search(subject)
    #link_to subject.capitalize + " (remove)", remove_from_search(subject)
  end

  def add_to_search(subject)
    request.params.merge({ subject: merged_subjects(subject), page: nil })
  end

  def remove_from_search(subject)
    request.params.merge({ subject: params[:subject].delete(subject) })
  end

  def merged_subjects(subject)
    if params[:subject].present?
      [params[:subject]] + [subject]
    else
      [subject]
    end
  end
end
