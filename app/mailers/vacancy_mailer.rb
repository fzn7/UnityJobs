class VacancyMailer < ActionMailer::Base
  default from: "notifier@flashjobs.ru"
  
  def creation_notice(vacancy)
    @vacancy = vacancy
    mail(:to => "support@adumentum.com", :subject => t("vacancy_mailer.creation_notice.subject", :title => @vacancy.title))
  end
  
  def approval_notice(vacancy)
    @vacancy = vacancy
    mail(:to => vacancy.email, :subject => t("vacancy_mailer.approval_notice.subject", :title => @vacancy.title))
  end
end
