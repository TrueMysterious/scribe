class PostResponse
  class Base
    include JSON::Serializable
  end

  class Root < Base
    property data : Data
  end

  class Data < Base
    property post : Post
  end

  class Post < Base
    property title : String
    property creator : Creator
    property content : Content
  end

  class Creator < Base
    property name : String
    property id : String
  end

  class Content < Base
    property bodyModel : BodyModel
  end

  class BodyModel < Base
    property paragraphs : Array(Paragraph)
  end

  class Paragraph < Base
    property text : String
    property type : ParagraphType
    property iframe : IFrame?
    property layout : String?
  end

  enum ParagraphType
    H3
    H4
    P
    PRE
    BQ
    ULI
    OLI
    IFRAME
    IMG
  end

  class IFrame < Base
    property mediaResource : MediaResource
  end

  class MediaResource < Base
    property id : String
  end

  class Metadata < Base
  end
end
