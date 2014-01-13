class OutlineViewController < NSObject
  extend IB

  outlet :myOutlineView, NSOutlineView

  def awakeFromNib
    @myOutlineView.setDelegate(self)
  end

  def top_level_items
    ["Favorites", "Content Views", "Mailboxes", "A Fourth Group"]
  end

  def children_items
    {
      "Favorites"      => ["ContentView1", "ContentView2", "ContentView3"],
      "Content Views"  => ["ContentView1", "ContentView2", "ContentView3"],
      "Mailboxes"      => ["ContentView2"],
      "A Fourth Group" => ["ContentView1", "ContentView2", "ContentView3"]
    }
  end

  def outlineView(outlineView, viewForTableColumn: tableColumn, item: item)
    if top_level_items.include?(item)
      result = outlineView.makeViewWithIdentifier("HeaderCell", owner:self)
      result.textField.setBezeled(false)
      result.textField.setDrawsBackground(false)
      result.textField.setEditable(false)
      result.textField.setSelectable(false)
      result.textField.setStringValue(item)

      return result
    else
      result = outlineView.makeViewWithIdentifier("DataCell", owner:self)
      result.textField.setBezeled(false)
      result.textField.setDrawsBackground(false)
      result.textField.setEditable(false)
      result.textField.setSelectable(false)
      result.textField.setStringValue(item)

      result.imageView = NSImageView.alloc.initWithFrame(NSMakeRect(0, 20, 100, 14))
      result.imageView.image = NSImage.imageNamed(NSImageNameIconViewTemplate)

      return result
    end
  end

  def outlineViewSelectionDidChange(notification)
    return
  end

  def outlineView(outlineView, numberOfChildrenOfItem:item)
    if item.nil?
      return top_level_items.count
    else
      return children_items[item].count
    end
  end

  def outlineView(outlineView, isItemExpandable:item)
    if top_level_items.include? item
      return true
    else
      return false
    end
  end

  def outlineView(outlineView, child:index, ofItem:item)
    if item.nil?
      return top_level_items[index]
    else
      return children_items[item][index]
    end
  end

end
