# Markdown Cheatsheet

**Warning `Large sum` of this article were created with `Gemini` with UltraPrompts: What-Would-Project-SHODAN-Diane-Say.md and human consultation of testing this repository; Diane is reference to Rick and Morty


#### Basic Formatting

- **Headers:** `# H1` through `###### H6`
- **Emphasis:** `**Bold**`, `*Italics*`, `~~Strikethrough~~`
- **Lists:** Use `*` or `-` for bullets, `1.` for numbers.
- **Links:** `[Text](URL)`
- **Code:** `Inline code` or triple backticks for blocks.
    

#### Mathematical Equations (LaTeX)

Markdown uses LaTeX syntax to render math. You can write it in two ways:
- **Inline Math:** Wrap the code in single dollar signs `$`.
    - _Input:_ `$E = mc^2$`
    - _Result:_ $E=mc2$
- **Display Math (Centered):** Wrap the code in double dollar signs `$$`.
    - _Input:_ `$$\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$`    
    - _Result:
    $$\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$


| **Component / Concept**  | **LaTeX Code**                                               | **Result**                                                   | **Sneaky Genius Tip**                                                                |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| **Fractions**            | `\frac{a}{b}`                                                | $\frac{a}{b}$                                                | Always put the bigger ego on top (usually yours).                                    |
| **Superscript**          | `a^{2}`                                                      | $a^{2}$                                                      | Use `{}` for exponents with more than one digit, or the math "breaks."               |
| **Subscript**            | `x_{i}`                                                      | $x_{i}$                                                      | Great for tracking which version of "you" we're talking about in the multiverse.     |
| **Summation**            | `\sum_{i=1}^{n}`                                             | $\sum_{i=1}^{n}$                                             | The `_` and `^` here stack the limits perfectly above and below.                     |
| **Infinity**             | `\infty`                                                     | $\infty$                                                     | The exact amount of patience I have for your "paranoid" garage projects.             |
| **Congruent**            | `\cong`                                                      | $\cong$                                                      | Use this when two things are basically the same, but you want to sound technical.    |
| **Closed Integral**      | `\oint_{S}`                                                  | $\oint_{S}$                                                  | The `\oint` adds the circle; it means the boundary is sealed tight.                  |
| **Vector Bold**          | `\mathbf{E}`                                                 | $\mathbf{E}$                                                 | Vectors have direction and magnitude; regular letters are just... lazy.              |
| **Dot Product**          | `\cdot`                                                      | $\cdot$                                                      | It’s the "mathematical kiss"—it shows how well two vectors align.                    |
| **Differential Area**    | `d\mathbf{A}`                                                | $d\mathbf{A}$                                                | Always bold the `A`; area in physics isn't just a size, it’s a point of view.        |
| **Enclosed Charge**      | `Q_{\text{enc}}`                                             | $Q_{\text{enc}}$                                             | Using `\text{}` prevents the letters from looking "italicized and lonely."           |
| **Epsilon Naught**       | `\varepsilon_{0}`                                            | $\varepsilon_{0}$                                            | Use `\varepsilon` (the curly one) to look like you studied at a higher dimension.    |
| **Nabla (Del)**          | `\nabla`                                                     | $\nabla$                                                     | The "upside-down triangle." It’s the operator that sniffs out changes in space.      |
| **Vector E (Arrow)**     | `\vec{\mathbf{E}}`                                           | $\vec{\mathbf{E}}$                                           | `\vec{}` adds the arrow; `\mathbf{}` makes it bold and professional.                 |
| **Dot Product**          | `\cdot`                                                      | $\cdot$                                                      | Essential for divergence! It means we're measuring how much the field "spreads out." |
| **Charge Density**       | `\rho`                                                       | $\rho$                                                       | Pronounced "row." It represents how much charge is packed into a tiny volume.        |
| **Epsilon Naught**       | `\varepsilon_0`                                              | $\varepsilon_0$                                              | The constant that keeps the universe's electrical "resistance" in check.             |
| **Curl (Nabla Cross)**   | `\nabla \times`                                              | $\nabla \times$                                              | The `\times` signifies the "twist" or rotation of the field.                         |
| **Magnetic Field**       | `\vec{\mathbf{B}}`                                           | $\vec{\mathbf{B}}$                                           | Always bold the B; magnetism is never just a scalar "vibe."                          |
| **Permeability**         | `\mu_0`                                                      | $\mu_0$                                                      | Pronounced "mew-naught." It’s the magnetic version of $\varepsilon_0$.               |
| **Current Density**      | `\vec{\mathbf{J}}`                                           | $\vec{\mathbf{J}}$                                           | This is the actual flow of charges (the "row" of moving electrons).                  |
| **Partial Derivative**   | `\frac{\partial}{\partial t}`                                | $\frac{\partial}{\partial t}$                                | Use `\partial` for time-variance; it’s more "sophisticated" than a regular `d`.      |
| **Displacement Current** | `\varepsilon_0 \frac{\partial \vec{\mathbf{E}}}{\partial t}` | $\varepsilon_0 \frac{\partial \vec{\mathbf{E}}}{\partial t}$ | This is Maxwell's big addition—the "ghost" current from changing E-fields.           |