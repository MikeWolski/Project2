import { CssBaseline } from "@mui/material";
import { createGlobalStyle } from "styled-components";

/**
 * Feel free to add any global styling to this project by writing valid CSS in the code below.
 */

const GlobalStyle = createGlobalStyle`
    html, body {
        background-color: #192437;
    }
`;

export const StyleProvider = ({ children }) => {
    return (
        <>
            <CssBaseline />
            <GlobalStyle />
            {children}
        </>
    );
}