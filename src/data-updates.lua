-- Common functions
-- This should be spun into its own file at some point, but I'm lazy. Later. I promise. Maybe.

-- -- Tech mutators
local function setTechEnabledValue(name, value)
  if data.raw.technology[name] then
    data.raw.technology[name].enabled = value
  end
end

-- -- Recipe mutators
local function setRecipeEnabledValue(name, value)
  if data.raw.recipe[name] then
    data.raw.recipe[name].enabled = value
  end
end
local function setRecipeHiddenValue(name, value)
  if data.raw.recipe[name] then
    data.raw.recipe[name].hidden = value
  end
end
local function setRecipeCategoryValue(name, value)
  if data.raw.recipe[name] then
    data.raw.recipe[name].category = value
  end
end
local function deleteRecipe(name)
  if data.raw.recipe[name] then
    data.raw.recipe[name] = nil
  end
end
local function setRecipeEnergyValue(name, value)
  if data.raw.recipe[name] then
    data.raw.recipe[name].energy_required = value
  end
end
local function setRecipeResultAmountValue(recipeName, resultName, amountValue)
  if data.raw.recipe[recipeName] then
    if data.raw.recipe[recipeName].results then
      for _, val in pairs (data.raw.recipe[recipeName].results) do
        if val.name == resultName then
          val.amount = amountValue
          break
        end
      end
    end
    if data.raw.recipe[recipeName].result and data.raw.recipe[recipeName].result == resultName then
      data.raw.recipe[recipeName].result_count = amountValue
    end
  end
end

-- Item mutators
local function setItemFuelValue(name, value)
  if data.raw.item[name] then
    data.raw.item[name].fuel_value = value
  end
end


-- Re-establish pre-2019.April charcoal and slag stuff.
for _, val in pairs(
  {
  {itemName = "wood-charcoal", newFuel = "2.5MJ", recipeName = "sb-wood-bricks-charcoal", newResultAmount = 12 }
  }) do
  setItemFuelValue(val.itemName, val.newFuel)
  setRecipeResultAmountValue(val.recipeName, val.itemName, val.newResultAmount)
end
for _, val in pairs(
  {
  { recipeName = "dirt-water-separation", energyRequired = 2 }
  }) do
  setRecipeEnergyValue(val.recipeName, val.energyRequired)
end

if settings.startup["CRSeaBlockRebalance-EnableBorers"].value then
  -- Re-enable water borers
  for _, val in pairs(
    {
    'water-bore-1',
    'water-bore-2',
    'water-bore-3',
    'water-bore-4'
    }) do
    setTechEnabledValue(val, true)
  end
  -- Disable the borer pure-water recipe
  for _, val in pairs(
    {
    "pure-water-pump"
    }) do
    setRecipeHiddenValue(val, true)
  end
end