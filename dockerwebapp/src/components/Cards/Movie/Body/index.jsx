import { Grid, CardContent } from '@mui/material';

export const Body = ({children, ...props}) => {
    return (
        <CardContent sx={{paddingTop: '0px'}} {...props}>
            <Grid container direction="column">
                {children}
            </Grid>
        </CardContent>
    );
}