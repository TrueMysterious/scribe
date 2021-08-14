require "../spec_helper"

include Nodes

describe PageContent do
  it "renders a single parent/child node structure" do
    page = Page.new(nodes: [
      Paragraph.new(children: [
        Text.new(content: "hi"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<p>hi</p>)
  end

  it "renders multiple childrens" do
    page = Page.new(nodes: [
      Paragraph.new(children: [
        Text.new(content: "Hello, "),
        Emphasis.new(children: [
          Text.new(content: "World!"),
        ] of Child),
      ] of Child),
      UnorderedList.new(children: [
        ListItem.new(children: [
          Text.new(content: "List!"),
        ] of Child),
        ListItem.new(children: [
          Text.new(content: "Again!"),
        ] of Child),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<p>Hello, <em>World!</em></p><ul><li>List!</li><li>Again!</li></ul>)
  end

  it "renders an anchor" do
    page = Page.new(nodes: [
      Anchor.new(children: [Text.new("link")] of Child, href: "https://example.com"),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<a href="https://example.com">link</a>)
  end

  it "renders a blockquote" do
    page = Page.new(nodes: [
      BlockQuote.new(children: [
        Text.new("Wayne Gretzky. Michael Scott."),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<blockquote>Wayne Gretzky. Michael Scott.</blockquote>)
  end

  it "renders code" do
    page = Page.new(nodes: [
      Code.new(children: [
        Text.new("foo = bar"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<code>foo = bar</code>)
  end

  it "renders empasis" do
    page = Page.new(nodes: [
      Paragraph.new(children: [
        Text.new(content: "This is "),
        Emphasis.new(children: [
          Text.new(content: "neat!"),
        ] of Child),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<p>This is <em>neat!</em></p>)
  end

  it "renders a figure and figure caption" do
    page = Page.new(nodes: [
      Figure.new(children: [
        Image.new(src: "image.png", originalWidth: 100, originalHeight: 200),
        FigureCaption.new(children: [
          Text.new("A caption"),
        ] of Child),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq stripped_html <<-HTML
      <figure>
        <img src="https://cdn-images-1.medium.com/fit/c/100/200/image.png" width="100">
        <figcaption>A caption</figcaption>
      </figure>
    HTML
  end

  it "renders an H3" do
    page = Page.new(nodes: [
      Heading2.new(children: [
        Text.new(content: "Title!"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<h2>Title!</h2>)
  end

  it "renders an H4" do
    page = Page.new(nodes: [
      Heading3.new(children: [
        Text.new(content: "In Conclusion..."),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<h3>In Conclusion...</h3>)
  end

  it "renders an image" do
    page = Page.new(nodes: [
      Paragraph.new(children: [
        Image.new(src: "image.png", originalWidth: 100, originalHeight: 200),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq stripped_html <<-HTML
      <p>
        <img src="https://cdn-images-1.medium.com/fit/c/100/200/image.png" width="100">
      </p>
    HTML
  end

  it "renders an iframe container" do
    page = Page.new(nodes: [
      Paragraph.new(children: [
        IFrame.new(href: "https://example.com"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq stripped_html <<-HTML
      <p>
        <div class="embedded">
          <a href="https://example.com">Embedded content at example.com</a>
        </div>
      </p>
    HTML
  end

  it "renders an ordered list" do
    page = Page.new(nodes: [
      OrderedList.new(children: [
        ListItem.new(children: [Text.new("One")] of Child),
        ListItem.new(children: [Text.new("Two")] of Child),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<ol><li>One</li><li>Two</li></ol>)
  end

  it "renders an preformatted text" do
    page = Page.new(nodes: [
      Paragraph.new(children: [
        Text.new("Hello, world!"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<p>Hello, world!</p>)
  end

  it "renders an preformatted text" do
    page = Page.new(nodes: [
      Preformatted.new(children: [
        Text.new("New\nline"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<pre>New\nline</pre>)
  end

  it "renders strong text" do
    page = Page.new(nodes: [
      Strong.new(children: [
        Text.new("Oh yeah!"),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<strong>Oh yeah!</strong>)
  end

  it "renders an unordered list" do
    page = Page.new(nodes: [
      UnorderedList.new(children: [
        ListItem.new(children: [Text.new("Apple")] of Child),
        ListItem.new(children: [Text.new("Banana")] of Child),
      ] of Child),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<ul><li>Apple</li><li>Banana</li></ul>)
  end

  it "renders a user anchor" do
    page = Page.new(nodes: [
      UserAnchor.new(children: [Text.new("Some User")] of Child, userId: "abc123"),
    ] of Child)

    html = PageContent.new(page: page).render_to_string

    html.should eq %(<a href="https://medium.com/u/abc123">Some User</a>)
  end
end

def stripped_html(html : String)
  html.gsub(/\n\s*/, "").strip
end
