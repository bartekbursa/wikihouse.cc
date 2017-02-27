class Slider < PushType::Node
  has_child_nodes false
  unexpose!

  field :caption,   :text
  field :dark_text, :boolean

  field :link_text, :string, validates: { presence: true, if: :link_url?  }
  field :link_url,  :string, validates: { presence: true, if: :link_text? }

  field :image_id, :asset, validates: { presence: true }

  field :image_position_horizontal, :select,
        choices: ["left", "center", "right"],
        validates: { presence: true }

  field :image_position_vertical, :select,
        choices: ["top", "center", "bottom"],
        validates: { presence: true }

  def self.sorted
    order "sort_order"
  end

  def self.with_parent_type(type)
    joins(:parent).where(parents_push_type_nodes: { type: type.to_s })
  end

  # This shouldn't be needed: https://github.com/pushtype/push_type/issues/33
  def link_url?
    link_url.present?
  end

  # This shouldn't be needed: https://github.com/pushtype/push_type/issues/33
  def link_text?
    link_text.present?
  end

  def image_url
    image.file.url
  end

  def image_position_vertical
    super || "center"
  end

  def image_position_horizontal
    super || "center"
  end
end
