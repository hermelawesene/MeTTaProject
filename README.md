# Recipe Recommendation Bot

A Python-based application that recommends recipes based on user-provided ingredients and dietary preferences. It leverages a **MeTTa knowledge base** for recipe data, **rule-based parsing** for input processing, **DistilGPT-2** for generating detailed recipe descriptions, and a **Streamlit web interface** for user interaction.

## Features

- **Input Parsing**: Enter ingredients (e.g., `tomatoes, pasta`) and dietary preferences (e.g., `vegetarian`) to find matching recipes.
- **Recipe Matching**: Uses MeTTa to match recipes based on available ingredients and dietary restrictions (`Vegetarian`, `Vegan`, `GlutenFree`).
- **Recipe Generation**: Generates recipe details (name, ingredients, steps) using DistilGPT-2.
- **Web UI**: Browser-based interaction via Streamlit at `http://localhost:8501`.
- **Extensible**: Add new ingredients and recipes to `recipes.metta`.

## Prerequisites

- **Python**: Version 3.7–3.10.
- **Virtual Environment**: Recommended for dependency management.
- **Operating System**: Tested on Linux (Ubuntu/Debian); compatible with macOS/Windows with minor adjustments.
- **Hardware**: CPU sufficient; GPU optional for faster DistilGPT-2 inference (~500MB RAM).

## Installation

1. **Clone the Repository** (or create the project directory):
   ```bash
   mkdir MeTTaProject
   cd MeTTaProject
   ```
   Save `main.py` and `recipes.metta` from this repository into `/home/hewe/MeTTaProject/`.

2. **Set Up a Virtual Environment**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install Dependencies**:
   ```bash
   pip install hyperon transformers torch streamlit
   ```
   - `hyperon`: MeTTa knowledge base.
   - `transformers`, `torch`: DistilGPT-2 model.
   - `streamlit`: Web UI.

   If installation fails, upgrade pip:
   ```bash
   pip install --upgrade pip
   ```

4. **Verify Streamlit**:
   ```bash
   streamlit hello
   ```
   If errors occur, ensure Python compatibility (3.7–3.10) or install as a user:
   ```bash
   pip install streamlit --user
   ```

## Project Structure

- **`main.py`**:
  - Rule-based parsing for user inputs.
  - MeTTa queries for recipe matching.
  - DistilGPT-2 for recipe descriptions.
  - Streamlit web UI.
- **`recipes.metta`**:
  - Defines ingredients (e.g., `Tomato`, `Pasta`, `OliveOil`).
  - Defines recipes (e.g., `PastaWithTomatoAndCheese`, `VeganStirFry`).
  - Specifies dietary restrictions and cooking times.

## Usage

1. **Run the Application**:
   ```bash
   streamlit run ui-steramlite.py
   ```
   - Opens a web interface at `http://localhost:8501`.
   - If port `8501` is busy, Streamlit suggests an alternative (e.g., `8502`).

2. **Interact with the UI**:
   - **Input**: Enter ingredients and dietary preferences (e.g., "tomatoes, pasta, vegetarian").
   - **Submit**: Click `Submit` to view recipes and descriptions.
   - **Clear**: Click `Clear` to reset input and output.
   - **Example Output**:
     ```
     You can make:
     - Pasta with Tomato and Cheese. Cooking time: 20 minutes
     NAME: Pasta with Tomato and Cheese
     INGREDIENTS:
     - tomato
     - pasta
     STEPS:
     1) Boil pasta in salted water until al dente.
     2) Mix chopped tomatoes with cooked pasta and serve.
     ```

3. **Debugging**:
   - Console logs show MeTTa query results (e.g., `All recipes (raw result): ...`).
   - Verify `recipes.metta` facts:
     ```python
     from hyperon import MeTTa
     metta = MeTTa()
     metta.run('(match &self (isa $recipe Recipe) $recipe)')
     ```
   - Check parsing:
     ```python
     print(f"Parsed: ingredients={ingredients}, dietary={dietary}")
     ```
     Add in `parse_input_keyword` in `main.py`.

## Adding New Recipes and Ingredients

1. **Edit `recipes.metta`**:
   - Add ingredients:
     ```metta
     (isa Mushroom Ingredient)
     ```
   - Add recipes:
     ```metta
     (isa MushroomRisotto Recipe)
     (hasIngredient MushroomRisotto Rice)
     (hasIngredient MushroomRisotto Mushroom)
     (cookingTime MushroomRisotto 40)
     (meetsDietaryRestriction MushroomRisotto Vegetarian)
     ```

2. **Update `main.py`**:
   - Add to `parse_input_keyword` synonyms:
     ```python
     synonyms = {..., 'mushrooms': 'Mushroom'}
     ```
   - Add to keyword list:
     ```python
     for ing in [..., 'mushroom']:
     ```

## Example Inputs and Outputs

- **Input**: `rice, carrots, soy sauce, vegan`
  - **Output**:
    ```
    You can make:
    - Vegan Stir Fry. Cooking time: 20 minutes
    NAME: Vegan Stir Fry
    INGREDIENTS:
    - rice
    - carrot
    STEPS:
    1) Cook rice until tender.
    2) Stir-fry carrots with soy sauce and serve over rice.
    ```

- **Input**: `tomato, basil, olive oil, glutenfree`
  - **Output**: `GlutenFreeSalad` with description.

- **Input**: `invalid`
  - **Output**: `Sorry, I couldn't identify any valid ingredients in your input.`

## Limitations

- **DistilGPT-2**: Generates basic steps due to its size (82M parameters). Consider `gpt2` for improved results (~1GB memory).
- **Input Parsing**: Rule-based, may miss complex phrases. Expand synonyms in `parse_input_keyword`.
- **MeTTa**: Requires accurate `recipes.metta` facts.
- **Performance**: LLM takes ~1–2 seconds per recipe on CPU; GPU accelerates this.

## Future Improvements

- **Enhanced LLM**: Use `t5-small` or `gpt2` for better recipe steps.
- **UI Features**: Add ingredient dropdowns in Streamlit:
  ```python
  ingredients_list = ['Tomato', 'Pasta', ..., 'SoySauce']
  selected_ingredients = st.multiselect("Select ingredients:", ingredients_list)
  ```
- **More Recipes**: Expand `recipes.metta` with diverse cuisines.
- **Input Validation**: Highlight unrecognized ingredients in the UI.

## Contributing

- **Pull Requests**: Add recipes, improve parsing, or enhance the UI.
- **Testing**: Verify new recipes in `recipes.metta` and parsing in `main.py`.

## License

MIT License (or specify your preferred license).

## Acknowledgments

- **Hyperon**: MeTTa knowledge base.
- **Hugging Face Transformers**: DistilGPT-2.
- **Streamlit**: Web UI.
- Developed as a student project in `/home/hewe/MeTTaProject/`.
