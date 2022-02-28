import { Grid, Typography } from '@mui/material';
import Header, { Title, Body } from './components/Header';
import { Movie as MovieCard } from './components/Cards';
import { DecoratedList } from './components/Lists';
import { Image } from './components/Image';
import movies from './utils/movies.example';

export const App = () => {
    return (
        <>
            <Grid container justifyContent="center">
                <Grid item>
                    {/* Please change the header title or body text to whatever you wish */}
                    <Header>
                        <Title>AzureDevops</Title>
                        <Body>Enter your text here.</Body>
                    </Header>
                </Grid>
            </Grid>
            <Grid container justifyContent="center" spacing={2} sx={{padding: '5em 0'}}>
                {
                movies.length > 0 
                ? movies.map((movie) => {
                    return (
                        <Grid item>
                            <MovieCard>
                                <MovieCard.Title 
                                    title={movie.title || ''}
                                    subheader={
                                        <DecoratedList>
                                            {!!movie.releaseYear ? <DecoratedList.Item>{movie.releaseYear}</DecoratedList.Item> : null }
                                            {!!movie.contentRating ? <DecoratedList.Item decorated>{movie.contentRating}</DecoratedList.Item> : null}
                                            {!!movie.runTime ? <DecoratedList.Item decorated>{movie.runTime}</DecoratedList.Item> : null}
                                        </DecoratedList>
                                    }
                                />
                                <MovieCard.Body>
                                    <Grid container>
                                        <Grid item xs={10} sx={{padding: '0px 5px 0px 0px'}}>
                                            <Grid container direction="column" spacing="1em">
                                                <MovieCard.Description>
                                                    <Typography>
                                                        {movie.description || ''}
                                                    </Typography>
                                                </MovieCard.Description>
                                                <MovieCard.Description>
                                                    <hr/>
                                                    <DecoratedList>
                                                        <DecoratedList.Item><strong>{movie?.directors?.length > 1 ? 'Directors' : 'Director'}</strong></DecoratedList.Item>
                                                        {movie?.directors?.map((director, index) => {
                                                            return (
                                                                <DecoratedList.Item decorated={index !== 0}>{director}</DecoratedList.Item>
                                                            );
                                                        })}
                                                    </DecoratedList>
                                                </MovieCard.Description>
                                                <MovieCard.Description>
                                                    <hr/>
                                                    <DecoratedList>
                                                        <DecoratedList.Item><strong>{movie?.writers?.length > 1 ? 'Writers' : 'Writer'}</strong></DecoratedList.Item>
                                                        {movie?.writers?.map((writer, index) => {
                                                            return (
                                                                <DecoratedList.Item decorated={index !== 0}>{writer}</DecoratedList.Item>
                                                            );
                                                        })}
                                                    </DecoratedList>
                                                </MovieCard.Description>
                                                <MovieCard.Description>
                                                    <hr/>
                                                    <DecoratedList>
                                                        <DecoratedList.Item><strong>{movie?.actors?.length > 1 ? 'Actors' : 'Actor'}</strong></DecoratedList.Item>
                                                        {movie?.actors?.map((actor, index) => {
                                                            return (
                                                                <DecoratedList.Item decorated={index !== 0}>{actor}</DecoratedList.Item>
                                                            );
                                                        })}
                                                    </DecoratedList>
                                                </MovieCard.Description>
                                            </Grid>
                                        </Grid>
                                        {!!movie.imageURL ? 
                                        <Grid item xs={2}>
                                            <Image src={movie.imageURL} width="100%"/>
                                        </Grid> :
                                        null}
                                    </Grid>
                                </MovieCard.Body>
                            </MovieCard>
                        </Grid>
                    );
                })
                : <MovieCard>
                    <Grid container justifyContent="center" textAlign="center">
                        <Grid item sx={{padding: '24px 5px 0px 0px'}}>
                            <MovieCard.Body>
                                <MovieCard.Description>
                                    <Typography sx={{maxWidth: '42vw', minWidth: '42vw'}}>
                                        The SkillStorm Movies repository is currently empty. If you'd like to add a movie, please go to src/utils/movies.js and add a movie by following the data format specified.
                                    </Typography>
                                </MovieCard.Description>
                            </MovieCard.Body>
                        </Grid>
                    </Grid>
                </MovieCard>}
            </Grid>
        </>
    );
}