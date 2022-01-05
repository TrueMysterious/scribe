class Home::IndexPage < MainLayout
  def page_title
    Application.settings.name
  end

  def content
    h1 "Scribe"
    h2 "An alternative frontend to Medium"
    para do
      a(
        "Here's an example",
        href: "/@ftrain/big-data-small-effort-b62607a43a8c"
      )
    end
    para "Custom domains work the too. See below for a How-To."
    article do
      section do
        h2 "How-To"
        para do
          text "To view a Medium post simply replace "
          code "medium.com", class: "highlight"
          text " with "
          code app_domain, class: "highlight"
        end
        para do
          text "If the URL is: "
          code do
            span "medium.com", class: "highlight"
            text "/@user/my-post-09a6af907a2"
          end
          text " change it to "
          code do
            span app_domain, class: "highlight"
            text "/@user/my-post-09a6af907a2"
          end
        end
        para do
          text "For articles on custom domains, instead of replacing "
          code "medium.com", class: "highlight"
          text " replace the custom domain. E.g. instead of "
          code do
            span "customdomain.com", class: "highlight"
            text "/blog/my-post-09a6af907a2"
          end
          text " change it to "
          code do
            span app_domain, class: "highlight"
            text "/blog/my-post-09a6af907a2"
          end
        end
      end
      section do
        h2 "How-To Automatically"
        para do
          text "Check out the "
          link "FAQ", to: Faq::Index
        end
      end
      mount Shared::LayoutFooter
    end
  end
end
