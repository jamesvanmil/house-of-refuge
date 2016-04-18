module GalleryImagesHelper
  def facet_link(subject)
    if params["subject"].nil?
      link_to subject.capitalize, add_to_search(subject)
    elsif params["subject"].include?(subject) 
      link_to subject.capitalize + " (remove)", remove_from_search(subject)
    else
      link_to subject.capitalize, add_to_search(subject)
    end
  end

  def add_to_search(subject)
    request.params.merge({ subject: merged_subjects(subject), page: nil })
  end

  def remove_from_search(subject)
    subjects = params[:subject].dup
    subjects.delete(subject)
    request.params.merge({ subject: subjects, page: nil })
  end

  def merged_subjects(subject)
    if params[:subject].present?
      params[:subject] + [subject]
    else
      [subject]
    end
  end
end
