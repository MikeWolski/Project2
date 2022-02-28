import { render } from 'react-dom';
import { StyleProvider } from './providers/StyleProvider';
import { App } from './App';

render(
    <StyleProvider>
        <App />
    </StyleProvider>,
    document.querySelector('#root')
);