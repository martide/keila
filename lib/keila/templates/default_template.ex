defmodule Keila.Templates.DefaultTemplate do
  @doc """
  DEPRECATED. Use `Keila.Templates.HybridTemplate` instead.

  Convenience module providing defaults for html and styles, as well as a style
  template configuration.
  """

  alias Keila.Templates.Css
  import KeilaWeb.Gettext

  @html_body File.read!("priv/email_templates/default.html.liquid") |> Solid.parse!()
  @styles File.read!("priv/email_templates/default.css") |> Css.parse!()

  get_styles = fn selector, properties ->
    Enum.map(properties, fn property ->
      value = Css.get_value(@styles, selector, property)
      %{selector: selector, property: property, default: value}
    end)
  end

  @style_template [
    {gettext("Layout"),
     get_styles.("body, #center-wrapper, #table-wrapper", [
       "background-color",
       "font-family"
     ])},
    {gettext("Content"),
     get_styles.("#content", [
       "color",
       "background-color",
       "font-family"
     ])},
    {gettext("Heading 1"),
     get_styles.("h1", [
       "color",
       "font-family",
       "font-style",
       "font-weight",
       "text-decoration"
     ])},
    {gettext("Heading 2"),
     get_styles.("h2", [
       "color",
       "font-family",
       "font-style",
       "font-weight",
       "text-decoration"
     ])},
    {gettext("Heading 3"),
     get_styles.("h3", [
       "color",
       "font-family",
       "font-style",
       "font-weight",
       "text-decoration"
     ])},
    {gettext("Links"),
     get_styles.("a", [
       "color",
       "text-decoration"
     ])},
    {gettext("Button"),
     get_styles.("h4>a, div.keila-button a", [
       "color"
     ]) ++
       get_styles.("h4>a, div.keila-button", [
         "background-color",
         "font-family",
         "font-style",
         "font-weight",
         "text-decoration"
       ])},
    {gettext("Spacer"),
     get_styles.("hr", [
       "border-color",
       "opacity",
       "border-style",
       "margin"
     ])},
    {gettext("Signature"),
     get_styles.("#signature td", [
       "color",
       "text-align",
       "font-family",
       "font-style",
       "font-weight",
       "text-decoration"
     ])},
    {gettext("Signature links"),
     get_styles.("#signature td a", [
       "color",
       "text-decoration"
     ])}
  ]

  @signature """
  [Unsubscribe]({{ unsubscribe_link }})

  Powered by [Keila - OpenSource Newsletters](https://www.keila.io/)
  """

  @deprecated "Use HybridTemplate instead"
  @spec styles() :: Keila.Templates.Css.t()
  def styles() do
    @styles
  end

  @deprecated "Use HybridTemplate instead"
  @spec html_template() :: %Solid.Template{}
  def html_template() do
    @html_body
  end

  @deprecated "Use HybridTemplate instead"
  @spec style_template() :: Keila.Templates.StyleTemplate.t()
  def style_template() do
    @style_template
  end

  @deprecated "Use HybridTemplate instead"
  @spec signature() :: String.t()
  def signature() do
    @signature
  end
end
