import { Card } from '@mui/material';
import { Title } from './Title';
import { Body } from './Body';
import { Footer } from './Footer';
import { Description } from './Description';

const Movie = ({children, ...props}) => {
    return (
        <Card sx={{maxWidth: '80vw', minWidth: '80vw'}} {...props}>
            {children}
        </Card>
    );
}

Movie.Title = Title;
Movie.Body = Body;
Movie.Footer = Footer;
Movie.Description = Description;

export { Movie };
export default Movie;